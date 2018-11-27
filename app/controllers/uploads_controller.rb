# frozen_string_literal: true

class UploadsController < ApplicationController
  def index; end

  def new
    @upload = Upload.new
    @uploads = [].tap do |files|
      Upload.with_attached_files.each { |upload| upload.files.each { |file| files << { file: file } } }
    end
  end

  def create
    upload = Upload.new(upload_params)
    if upload.save
      flash[:success] = 'File upload successful!'
    else
      flash[:danger] = 'An error occurred. Please try again!'
    end
    redirect_to root_path
  end

  def destroy
    upload = Upload.with_attached_files.find(params[:id])
    if upload.files.purge
      upload.destroy
      flash[:success] = 'File deleted successful!'
    else
      flash[:danger] = 'An error occurred. Please try again!'
    end
    redirect_to root_path
  rescue StandardError => error
    flash[:danger] = 'File does not exist!'
    redirect_to root_path
  end

  private

  def upload_params
    params.require(:upload).permit(files: [])
  end
end

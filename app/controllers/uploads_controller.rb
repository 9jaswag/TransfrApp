class UploadsController < ApplicationController
  def index
  end

  def new
    @upload = Upload.new
    @uploads = [].tap do |files|
      Upload.all.each { |upload| upload.files.each { |file| files << { file: file } } }
    end
  end

  def create
    upload = Upload.new(upload_params)
    if upload.save
      redirect_to root_path
      flash[:success] = "File(s) successfully uploaded."
    else
      redirect_to root_path
      flash[:danger] = "An error occurred. Please try again."
    end
  end

  def destroy
  end

  private
  def upload_params
    params.require(:upload).permit(:name, files: [])
  end
end

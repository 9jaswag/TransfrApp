class UploadsController < ApplicationController
  def index
  end

  def new
    @upload = Upload.new
  end

  def create
  end

  def destroy
  end

  private
  def upload_params
    params.require(:upload).permit(:name, files: [])
  end
end

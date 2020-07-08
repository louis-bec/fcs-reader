class S3FilesController < ApplicationController
  def index
    @s3_files = S3File.all
  end

  def new
    @s3_file = S3File.new
  end

  def create
    @s3_file = S3File.new(s3_file_params)

    if @s3_file.save
      redirect_to fcs_files_path, notice: 'file uploaded to the s3'
    else
      render 'new'
    end
  end

  def show
    @s3_file = S3File.find(params[:id])
  end

  def destroy
    @s3_file = S3File.find(params[:id])
    @s3_file.destroy
    redirect_to s3_files_path, notice: 'file deleted from s3'
  end

  private

  def s3_file_params
    params.require(:s3_file).permit(:name, :url)
  end
end

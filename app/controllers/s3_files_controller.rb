require 'aws-sdk'

class S3FilesController < ApplicationController
  def index
    @s3_files = S3File.all
  end

  def new
    @s3_file = S3File.new
  end

  def create
    @s3_file = S3File.new(s3_file_params)
    saved_file = @s3_file.save

    if saved_file
      # upload file to s3
      s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
      bucket_name = ProjectConfig.aws_s3_bucket_name
      bucket = s3.bucket(bucket_name)

      if bucket.exists?
        name = s3_file_params[:url].original_filename
        path = "#{Dir.getwd}/public#{@s3_file.url_url}"

        # Check if file is already in bucket
        if bucket.object(name).exists?
          puts "#{name} already exists in the bucket"
        else
          obj = bucket.object(name)
          obj.upload_file(path)
          puts "Uploaded '%s' to S3!" % name
        end
      else
        NO_SUCH_BUCKET % bucket_name
      end
    else
      puts 'file save failed'
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

  def download
    puts 'file will be download'
  end

  private

  def s3_file_params
    params.require(:s3_file).permit(:name, :url)
  end
end

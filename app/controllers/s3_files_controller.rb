# frozen_string_literal: true

require 'aws-sdk'

class S3FilesController < ApplicationController
  def index
    # @s3_files = S3File.all
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    bucket = s3.bucket(bucket_name)

    if bucket.exists?
      @s3_files = bucket.objects.limit(50).map do |obj|
        {
          name: obj.key,
          url: obj.public_url
        }
      end
    else
      flash[:notice] = "bucket - #{bucket_name} not exists"
    end
  end

  def new
    @s3_file = S3File.new
  end

  def create
    @s3_file = S3File.new(s3_file_params)
    saved_file = @s3_file.save
    notice_message = ''

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
          notice_message = "#{name} already exists in the bucket!"
        else
          obj = bucket.object(name)
          obj.upload_file(path)
          notice_message = "Uploaded #{name} to S3!"
        end
      else
        notice_message = "No such bucket - #{bucket_name}!"
      end
    else
      notice_message = 'file save failed!'
    end
    redirect_to s3_files_path, notice: notice_message
  end

  def show
    # @s3_file = S3File.find(params[:id])
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    @obj = s3.bucket(bucket_name).object(params[:name])
    puts @obj
  end

  def destroy
    # @s3_file = S3File.find(params[:id])
    # @s3_file.destroy
    # redirect_to s3_files_path, notice: 'file deleted from s3'
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    obj = s3.bucket(bucket_name).object(params[:name])
    result = obj.delete
    redirect_to s3_files_path, notice: "file - #{params[:name]} deleted!"
  end

  def download
    puts 'file will be download'
  end

  private

  def s3_file_params
    params.require(:s3_file).permit(:name, :url)
  end
end

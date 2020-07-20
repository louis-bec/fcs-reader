# frozen_string_literal: true

require 'aws-sdk'

class S3FilesController < ApplicationController
  def index
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    bucket = s3.bucket(bucket_name)

    if bucket.exists?
      @s3_files = bucket.objects.limit(50).map do |obj|
        {
          name: obj.key,
          url: obj.presigned_url(:get),
          download_url: obj.presigned_url(:get)
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
        name = [ProjectConfig.aws_s3_upload_path, s3_file_params[:url].original_filename].join('/')
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
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    @obj = s3.bucket(bucket_name).object(params[:name])
    puts @obj
  end

  def destroy
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    obj = s3.bucket(bucket_name).object(params[:name])
    obj.delete
    redirect_to s3_files_path, notice: "file - #{params[:name]} deleted!"
  end

  def download
    render layout: false
    s3 = Aws::S3::Resource.new(region: ProjectConfig.aws_s3_region)
    bucket_name = ProjectConfig.aws_s3_bucket_name
    obj = s3.bucket(bucket_name).object(params[:name])
    # check if object exist on s3
    if obj.exists?
      download_s3_object obj
    else
      # is there anyway to display a message on previous page??
      # leave error handler for now
      flash[:notice] = "file - #{obj.key} not exists."
    end
  end

  private

  def s3_file_params
    params.require(:s3_file).permit(:name, :url)
  end

  def download_s3_object(s3_obj)
    # download from s3 to local if file not exists
    s3_tmp_download_dir = "#{Rails.root}/public/tmp_download"
    Dir.mkdir s3_tmp_download_dir unless Dir.exist? s3_tmp_download_dir
    # Dir.mktmpdir nil, s3_tmp_download_dir do |dir|
    #   file_path = "#{dir}/#{s3_obj.key}"
    #   raise 'can\'t not download from s3' unless s3_obj.download_file file_path

    #   send_file file_path, filename: s3_obj.key
    #   puts "success"
    # end
    file_path = "#{s3_tmp_download_dir}/#{s3_obj.key}"
    raise 'can\'t not download from s3' unless s3_obj.download_file file_path

    send_file file_path, filename: s3_obj.key
  end
end

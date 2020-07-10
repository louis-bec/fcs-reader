# frozen_string_literal: true

require 'rails_helper'

RSpce.describe ProjectConfig do
  context 'when read config successfully' do
    before do
      # set stub global variable - CONFIG
      $CONFIG = {
        'aws': {
          's3_bucket_name': 'test_bucket_name',
          's3_region': 'test_region'
        }
      }
    end

    it 'read aws s3 bucket name from config file' do
      expect(ProjectConfig.aws_s3_bucket_name).to eq('test_bucket_name')
    end

    it 'read asw s3 region from config file' do
      expect(ProjectConfig.aws_s3_region).to eq('test_region')
    end
  end
end

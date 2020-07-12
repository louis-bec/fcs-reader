# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectConfig do
  context 'read config successfully' do
    before do
      # arrange
      allow(Rails.configuration).to receive(:project_config) do
        {
          :aws => {
            :s3_bucket_name => 'test_bucket_name',
            :s3_region => 'test_region'
          }
        }
      end
    end

    it 'return aws s3 bucket name from config file' do
      # assert
      expect(ProjectConfig.aws_s3_bucket_name).to eq('test_bucket_name')
    end

    it 'return asw s3 region from config file' do
      # assert
      expect(ProjectConfig.aws_s3_region).to eq('test_region')
    end
  end

  context 'failed to read config' do    
    before do
      # arrange
      allow(Rails.configuration).to receive(:project_config) do
        {
          :aws => {}
        }
      end
    end

    it 'raise error since aws s3 bucket name not exist' do
      begin
        # act
        ProjectConfig.aws_s3_bucket_name
        expect(1).to eq(0)
      rescue StandardError => e
        # assert
        expect(e.message).to eq('can not find s3_bucket_name from aws')
      end
    end

    it 'return no_region as default value' do
      # assert
      expect(ProjectConfig.aws_s3_region).to eq('no_region')
    end
  end
end

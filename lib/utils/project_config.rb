# frozen_string_literal: true
require 'yaml'

class ProjectConfig
  class <<self
    def aws_s3_bucket_name
      get_config [:aws, :s3_bucket_name]
    end

    def aws_s3_region
      get_config [:aws, :s3_region], 'no_region'
    end

    def get_config(path, default = :no_default)
      path = [path] unless path.is_a? Array
      path_backup = path.clone

      raise 'path can not be blank' if path.blank?

      value = Rails.configuration.project_config

      until path.empty?
        key = path.shift

        if value.key? key
          value = value[key]
        else
          raise "can not find #{key} from #{path_backup}" if default == :no_default

          return default
        end
      end
      value
    end
  end
end

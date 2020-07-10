# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'yaml'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FcsReader
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # extent auto_load
    config.eager_load_paths += [
      %w[lib utils]
    ].map do |path|
      Rails.root.join(*path).to_s
    end

    # Load configuration file, it can be access by $CONFIG
    config_yml_path = Rails.root.join('config', 'config.yml').to_s

    if File.exist?(config_yml_path)
      begin
        config.project_config = config_for(:config)
      rescue StandardError => e
        puts "Error: #{e.message}"
        raise e
      end
    else
      puts "can not find file: #{config_yml_path}"
    end
  end
end

# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class SetupsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates setup lines'

    def create_controller_files
      Rails.configuration.sitemap_config_variable
    rescue
      inject_into_file 'config/application.rb', :before => "  end" do
        "\n    config.sitemap_config_variable = {}" +
          "\n    config.sitemap_config_variable[:production_url] = 'https://YOUR-PRODUCTION-URL.com'\n\n"
      end
    end
  end
end
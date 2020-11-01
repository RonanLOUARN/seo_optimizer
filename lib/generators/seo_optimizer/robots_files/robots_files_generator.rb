# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class RobotsFilesGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates robots files'

    def create_controller_files
      prod_variable = Rails.configuration.sitemap_config_variable rescue raise(SeoOptimizer::Error, setup_error_message)
      url = prod_variable[:production_url]
      raise SeoOptimizer::Error, replace_url_error if !url || url == 'https://YOUR-PRODUCTION-URL.com'

      site_map_xml
      robots_text
    end

    private

    def robots_text
      routing_code = %(get 'robots.:format', to: 'robots#show')
      route routing_code
      %x(rm -f public/robots.txt)
      template 'robots_controller_template.erb', File.join('app/controllers', 'robots_controller.rb')
      %x(mkdir -p app/views/robots)
      template 'robots_show_template.erb', File.join('app/views/robots', 'show.txt.erb')
    end

    def site_map_xml
      routing_code = %(get 'sitemap.xml', to: 'sitemaps#show', as: :sitemap, defaults: { format: :xml })
      route routing_code
      template 'sitemaps_controller_template.erb', File.join('app/controllers', 'sitemaps_controller.rb')
      template 'sitemaps_task_template.erb', File.join('lib/tasks/sitemap', 'generate.rake')
    end

    def replace_url_error
      '
        Please replace https://YOUR-PRODUCTION-URL.com by your production url in application.rb,
        check the doc https://github.com/RonanLOUARN/seo_optimizer for more infos.
      '
    end

    def setup_error_message
      '
        Please type "rails generate seo_optimizer:setups" in terminal,
        check the doc https://github.com/RonanLOUARN/seo_optimizer for more infos.
      '
    end
  end
end
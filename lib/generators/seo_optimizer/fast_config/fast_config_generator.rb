# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class FastConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates base setup file'
    class_option :pse, type: :boolean

    def call_commands
      generate 'seo_optimizer:meta_tags'
      generate 'seo_optimizer:errors_pages'
      generate 'seo_optimizer:setups'
      generate 'seo_optimizer:robots_files'
      rake 'sitemap:generate'
      return unless options[:pse]

      puts 'Ping search engines.'
      rake 'sitemap:ping_search_engines'
    end
  end
end

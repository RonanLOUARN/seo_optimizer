# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class FastConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates base setup file'

    def add_meta_tags
      generate 'seo_optimizer:meta_tags'
      generate 'seo_optimizer:error_pages'
      generate 'seo_optimizer:setups'
      generate 'seo_optimizer:robots_files'
      rake 'sitemap:generate'
    end
  end
end

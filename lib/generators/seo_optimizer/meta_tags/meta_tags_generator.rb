# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class MetaTagsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates meta tags'

    def add_meta_tags
      inject_into_file 'app/views/layouts/application.html.erb', after: '<head>' do
        File.open("#{File.expand_path('templates', __dir__)}/meta_tags.erb").read
      end
      template 'meta_tags_helper.erb', File.join('app/helpers', 'meta_tags_helper.rb')
      template 'default_meta.erb', File.join('config/initializers', 'default_meta.rb')
      template 'meta_yml.erb', File.join('config', 'meta.yml')
    end
  end
end

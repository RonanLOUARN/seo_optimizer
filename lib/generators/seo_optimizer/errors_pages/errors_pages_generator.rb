# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class ErrorsPagesGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    desc 'Generates errors pages'

    def create_controller_files
      route %(get '/500' => 'errors#internal_server_error'\nget '/404' => 'errors#not_found'\n)

      inject_into_file 'config/application.rb', :before => "  end" do
        "\n    config.exceptions_app = self.routes\n"
      end
      %x(rm -f public/404.html)
      %x(rm -f public/500.html)
      template 'errors_controller_template.erb', File.join('app/controllers', 'errors_controller.rb')
      template '404.erb', File.join('app/views/errors', 'not_found.html.erb')
      template '500.erb', File.join('app/views/errors', 'internal_server_error.html.erb')
    end
  end
end
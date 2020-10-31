# frozen_string_literal: true

require 'rails/generators/migration'

module SeoOptimizer
  class ModelsGenerator < Rails::Generators::NamedBase
    include Rails::Generators::Migration
    source_root File.expand_path('templates', __dir__)
    desc 'Generates migration for models'

    def self.orm
      Rails::Generators.options[:rails][:orm]
    end

    def self.orm_has_migration?
      [:active_record].include? orm
    end

    def self.next_migration_number(_path)
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def create_migration_file
      return unless self.class.orm_has_migration?


      migration_template 'model_template.erb',
                         "db/migrate/add_#{model_name}_seo_slug_migration.rb",
                         migration_version: migration_version,
                         model_name: model_name,
                         model_table: model_table,
                         desired_fields_reference: desired_fields_reference

    end

    def model
      name.split(':').first
    end

    def fields
      name.split(':')[1..]
    end

    def model_name
      model.downcase
    end

    def model_table
      model_name.pluralize(2)
    end

    def desired_fields_reference
      fields.join(', ')
    end

    def migration_version
      if rails5?
        '[4.2]'
      elsif rails6?
        '[6.0]'
      end
    end

    def rails5?
      Rails.version.start_with? '5'
    end

    def rails6?
      Rails.version.start_with? '6'
    end
  end
end
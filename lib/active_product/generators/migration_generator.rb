require 'rails/generators'
require 'rails/generators/migration'

module ActiveProduct
  module Generators
    class MigrationGenerator < Rails::Generators::Base

      include Rails::Generators::Migration

      def self.source_root
        File.join(File.dirname(__FILE__), 'templates')
      end

      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      argument :name

      def create_migration 
        # just naively use the migration template based on the name
        # name - [base, status]
        migration_template "products_#{name}_migration.rb", 
        "db/migrate/active_product_products_#{name}_migration.rb"
      end
    end
  end
end
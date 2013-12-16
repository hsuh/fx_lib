require 'rails/generators/migration'

module FxRate
  module Generators
    class Base < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        @_fx_rate_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'fx_rate', generator_name, 'templates'))
      end

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
    end
  end
end

require 'generators/fx_rate'

module FxRate
  module Generators
    class MigrationGenerator < Base
      desc "Generate fx_rates migration"

      def create_migration_file
        migration_template "create_fx_rate_table.rb", File.join('db', 'migrate', 'create_fx_rate_table.rb')
      end
    end
  end
end

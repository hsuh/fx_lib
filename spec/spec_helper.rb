require 'rubygems'
require 'bundler'
require 'fx_lib.rb'

Bundler.require :default, :development
Combustion.initialize! :active_record

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

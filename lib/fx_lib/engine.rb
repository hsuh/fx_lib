require 'rails'

module FxLib
  class Engine < Rails::Engine

    initializer "fx_lib.load_app_instance_data" do |app|
      FxLib.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "fx_lib.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'lib/tasks/*.rake')].each {|f| load f}
    end
  end
end

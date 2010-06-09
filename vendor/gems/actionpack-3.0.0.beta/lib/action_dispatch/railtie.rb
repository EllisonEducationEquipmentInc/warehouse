require "action_dispatch"
require "rails"

module ActionDispatch
  class Railtie < Rails::Railtie
    railtie_name :action_dispatch

    # Prepare dispatcher callbacks and run 'prepare' callbacks
    initializer "action_dispatch.prepare_dispatcher" do |app|
      # TODO: This used to say unless defined?(Dispatcher). Find out why and fix.
      require 'rails/dispatcher'
      ActionDispatch::Callbacks.to_prepare { app.routes_reloader.reload_if_changed }
    end
  end
end
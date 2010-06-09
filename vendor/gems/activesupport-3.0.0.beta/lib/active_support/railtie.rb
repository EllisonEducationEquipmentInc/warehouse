require "active_support"
require "rails"

module ActiveSupport
  class Railtie < Rails::Railtie
    railtie_name :active_support

    # Loads support for "whiny nil" (noisy warnings when methods are invoked
    # on +nil+ values) if Configuration#whiny_nils is true.
    initializer "active_support.initialize_whiny_nils" do |app|
      require 'active_support/whiny_nil' if app.config.whiny_nils
    end

    # Sets the default value for Time.zone
    # If assigned value cannot be matched to a TimeZone, an exception will be raised.
    initializer "active_support.initialize_time_zone" do |app|
      require 'active_support/core_ext/time/zones'
      zone_default = Time.__send__(:get_zone, app.config.time_zone)

      unless zone_default
        raise \
          'Value assigned to config.time_zone not recognized.' +
          'Run "rake -D time" for a list of tasks for finding appropriate time zone names.'
      end

      Time.zone_default = zone_default
    end
  end
end

module I18n
  class Railtie < Rails::Railtie
    railtie_name :i18n

    # Initialize I18n load paths to an array
    config.i18n.engines_load_path = []
    config.i18n.load_path = []

    initializer "i18n.initialize" do
      require 'active_support/i18n'

      ActionDispatch::Callbacks.to_prepare do
        I18n.reload!
      end
    end

    # Set the i18n configuration from config.i18n but special-case for
    # the load_path which should be appended to what's already set instead of overwritten.
    config.after_initialize do |app|
      app.config.i18n.each do |setting, value|
        case setting
        when :engines_load_path
          app.config.i18n.load_path.unshift(*value)
        when :load_path
          I18n.load_path += value
        else
          I18n.send("#{setting}=", value)
        end
      end

      I18n.reload!
    end
  end
end
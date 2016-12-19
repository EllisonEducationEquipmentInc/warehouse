Warehouse::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'pos.ellison.com' }
  config.action_mailer.delivery_method = :smtp

  # Enable threaded mode
  # config.threadsafe!
  #
  config.action_mailer.smtp_settings = {
     :address              => "smtp.sendgrid.net",
     :port                 => 587,
     :user_name            => 'ey_service_19384@engineyard.com',
     :password             => 'cpjmgrdk3031',
     :enable_starttls_auto => true
    }
end

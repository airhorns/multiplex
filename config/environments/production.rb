Multiplex::Application.configure do
  Multiplex::Application::Domain = "othermail.me"
  Multiplex::Application::MixpanelKey = "563b3f5f6d1818e8292160ca0dcea950" 
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Comment out for heroku
  # Specifies the header that your server uses for sending files
  #config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  # True for heroku in prod
  config.serve_static_assets = true

  # Enable serving of images, stylesheets, and javascripts from an asset server
  config.action_controller.asset_host = Multiplex::Application::Domain

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.asset_host = Multiplex::Application::Domain
  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Host configuration 
  config.action_mailer.default_url_options = { :host => Multiplex::Application::Domain }

  ENV['REDISTOGO_URL'] ||= "redis://redistogo:bc92454f58b3943d285a82b3659e25b8@icefish.redistogo.com:9233/"

  config.middleware.use "Mixpanel::Tracker::Middleware", Multiplex::Application::MixpanelKey, :async => true
end

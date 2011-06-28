Multiplex::Application.configure do
  Multiplex::Application::Domain = "watch.skylightlabs.ca"
  Multiplex::Application::MixpanelKey = "9871c75f5bb84f252834a20c6be6ab4b" 
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  #config.action_mailer.raise_delivery_errors = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  #config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.action_mailer.default_url_options = { :host => "47p5.localtunnel.com" }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  ENV["REDISTOGO_URL"] = 'redis://localhost:6379'
  config.middleware.use "Mixpanel::Tracker::Middleware", Multiplex::Application::MixpanelKey, :async => true
end

class MultiplexJob
  if Rails.env.production?
    require 'rpm_contrib/instrumentation/resque'
    extend Resque::Plugins::NewRelicInstrumentation
  end
end

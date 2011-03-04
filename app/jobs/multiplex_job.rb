class MultiplexJob
  extend Resque::Plugins::HerokuAutoscaler if Rails.env.production?
end

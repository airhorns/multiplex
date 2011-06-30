require 'resque/plugins/resque_heroku_autoscaler'

class MultiplexJob
  extend Resque::Plugins::HerokuAutoscaler if Rails.env.production?
end

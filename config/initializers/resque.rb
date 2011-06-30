require 'resque'
require 'resque_scheduler'
require 'resque/plugins/resque_heroku_autoscaler'

Resque::Plugins::HerokuAutoscaler.config do |c|
  c.scaling_disabled = true unless Rails.env.production?
  c.new_worker_count do |pending|
    if pending == 0
      0
    else
      [(pending/5).ceil.to_i, 4].min
    end
  end
end

Resque.redis = ENV['REDISTOGO_URL']
Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/schedule.yml')) # load the schedule

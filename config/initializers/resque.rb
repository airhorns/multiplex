require 'resque'
require 'resque_scheduler'

Resque.redis = ENV['REDISTOGO_URL']
Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/schedule.yml')) # load the schedule

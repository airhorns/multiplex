source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem "devise"
gem "simple_form"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "resque"
gem "resque-scheduler"
gem "uuid"
gem "mail"
gem "pg"

gem "money"
gem "activemerchant"

gem 'activeadmin'
gem 'mixpanel'
gem "heroku"

group :production do
  gem "thin"
  #gem "resque-heroku-autoscaler", :require => "resque/plugins/resque_heroku_autoscaler", :git => "https://github.com/bborn/resque-heroku-autoscaler.git"
  gem "jammit_lite", :git => "https://github.com/hornairs/jammit_lite.git"
  gem "newrelic_rpm"
end

group :development, :test do
  # CSS Fandangling
  gem "compass"
  gem 'jammit'
  
  gem "mongrel", "1.2.0.pre2"
  gem 'ruby-debug19'
  gem 'sqlite3'

  gem "rspec-rails"
  gem 'spork', '~> 0.9.0.rc'  
  gem "steak"
  gem "capybara"
  gem "factory_girl", "2.0.0.beta2"
  gem 'factory_girl_rails', "1.1.beta1"
  
  gem "guard"
  gem "guard-rspec"
  gem "guard-coffeescript"
  gem "guard-compass"
  gem "guard-spork"
  gem 'guard-jammit'

  gem "growl"
  gem "rb-fsevent"

  gem "foreman"
end

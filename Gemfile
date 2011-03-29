source 'http://rubygems.org'

gem 'rails', '3.0.4'
gem "devise", "1.2.rc"
gem "simple_form"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "compass"
gem "resque"
gem "resque-scheduler"
gem "uuid"
gem "mail"
gem "pg"
gem "heroku" # need in all groups for the autoscaler as well as developingt c

group :production do
  gem "resque-heroku-autoscaler", :require => "resque/plugins/resque_heroku_autoscaler"
  #gem "jammit_lite", :path => "~/Code/jammit_lite"
  #gem "jammit_lite", :git => "https://github.com/chatgris/jammit_lite.git"
  gem "jammit_lite", :git => "https://github.com/hornairs/jammit_lite.git"
end

group :development, :test do
  gem "mongrel", "1.2.0.pre2"
  gem 'ruby-debug19'
  gem 'sqlite3'
  gem 'jammit'

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
end

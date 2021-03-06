# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)
require 'resque/server'
require 'resque_scheduler'

Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "5ky11ght"
end

run Rack::URLMap.new \
  "/"       => Multiplex::Application,
  "/resque" => Resque::Server.new

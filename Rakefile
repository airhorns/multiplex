# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'resque/tasks'
require 'resque_scheduler/tasks'

Multiplex::Application.load_tasks

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

desc "Alias for schedule"
task "cron" => "resque:scheduler"

desc "Make asset packages"
task "jam" do
  require 'jammit'
  Jammit.package!
end 

desc "Invite a user to otherbox"
task :invite, :email, :needs => :environment do |t, args|
  unless user = User.find_by_email(args[:email])
    UserMailer.invite(args[:email]).deliver!
  else
    puts "User already exists as #{user.mask_email}!"
  end
end


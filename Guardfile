# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#
#guard 'spork' do
  #watch('config/application.rb')
  #watch('config/environment.rb')
  #watch(%r{^config/environments/.*\.rb$})
  #watch(%r{^config/initializers/.*\.rb$})
  #watch('spec/spec_helper.rb')
#end

guard 'rspec', :version => 2 do
  watch(/^spec\/(.*)_spec.rb/)
  watch(/^spec\/spec_helper.rb/)                        { "spec" }
  watch(/^app\/(.*)\.rb/)                               { |m| "spec/#{m[1]}_spec.rb" }
  watch(/^config\/routes.rb/)                           { "spec/routing" }
  watch(/^app\/controllers\/application_controller.rb/) { "spec/controllers" }
  watch(/^spec\/factories.rb/)                          { "spec/models" }
end

guard 'compass' do
  watch(/^\/app\/stylesheets\/(.*)\.s[ac]ss/)
end

guard 'coffeescript', :output => 'public/javascripts' do
  watch(%r{app/coffeescripts/.+\.coffee})
end

guard 'jammit' do
  watch(/^public\/javascripts\/(.*)\.js/)
  watch(/^public\/stylesheets\/(.*)\.css/)
end

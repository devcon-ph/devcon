guard 'bundler' do
  watch('Gemfile')
end

guard :unicorn, :port => 3000, :daemonized => true do
  watch(%r{^app\/(controllers|models|helpers)\/.+\.rb$})
  watch(%r{^lib\/.+\.rb$})
  watch('Gemfile.lock')
  watch('config/routes.rb')
  watch('config/application.rb')
end

guard 'spork', wait: 60, cucumber: false, rspec: true, test_unit: false do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('spec/spec_helper.rb')
end

guard 'rspec', cli: '--drb --format progress --color' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/factories/(.+).rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
end

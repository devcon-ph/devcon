require "bundler/capistrano"

set :deploy_via, :remote_cache
set :application, "devcon"
set :repository, "git://github.com/devcon-ph/devcon.git"
set :deploy_to, "/home/deploy/apps/devcon/"

set :scm, :git

default_run_options[:pty] = true
default_run_options[:shell] = "/bin/bash --login"

server "beta.devcon.ph", :app, :web, :db, :primary => true
set :user, "deploy"
set :use_sudo, false

depend :remote, :gem, "bundler"

set :rails_env, "production"

# for carrierwave
set :shared_children, shared_children + %w{public/uploads}

after "deploy:setup", :create_unicorn_socket
before "deploy:restart", :symlink_unicorn_socket

task :create_unicorn_socket do
  run "mkdir #{shared_path}/sockets -p"
end

task :symlink_unicorn_socket do
  run "ln -s #{shared_path}/sockets #{current_path}/tmp/sockets"
end

before "deploy:finalize_update", :copy_production_database_configuration, :replace_secret_token

task :copy_production_database_configuration do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

task :replace_secret_token do
  run "cp #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
end

after "deploy:update", "deploy:cleanup", "deploy:migrate" 

require "capistrano-unicorn"

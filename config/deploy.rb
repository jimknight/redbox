require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "198.211.96.39", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "redbox"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :host_name, "redbox.lavatech.com"

set :scm, "git"
set :repository, "git@github.com:jimknight/redbox.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :upload_settings do
    top.upload("config/application.yml", "#{release_path}/config/application.yml", :via => :scp)
  end
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
end

after 'deploy',  'deploy:upload_settings'
after 'deploy', 'deploy:symlink_uploads'

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => assets_role, :except => { :no_release => true } do
      run <<-CMD.compact
        cd -- #{latest_release.shellescape} &&
        #{rake} RAILS_ENV=#{rails_env.to_s.shellescape} #{asset_env} assets:precompile
      CMD
    end
  end
end
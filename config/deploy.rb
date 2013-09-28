require "bundler/capistrano"

server "tba.colby.io", :web, :app, :db, primary: true

set :application, "tba"
set :user, "jeff"
set :deploy_to,  "/var/www/tba.colby.io/"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:jeffcarp/tba"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

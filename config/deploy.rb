require 'bundler/capistrano'

set :user, "www-data"
set :application, "dropply"
set :repository,  "git@github.com:colinyoung/dropply.git"
set :deploy_to, "/var/www/public_html/dropp.ly"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "dropp.ly"                          # Your HTTP server, Apache/etc
role :app, "dropp.ly"                          # This may be the same as your `Web` server
role :db,  "dropp.ly", :primary => true # This is where Rails migrations will run
role :db,  "dropp.ly"

after :deploy, "deploy:copy_database_yml"
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :copy_database_yml do
    run "cp /var/www/public_html/dropp.ly/database.yml #{File.join(current_path)}/config"
  end
end
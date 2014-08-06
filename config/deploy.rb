require 'bundler/capistrano'

require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3@listenlater'
before 'deploy', 'rvm:create_gemset'
set :rvm_type, :user
set :use_sudo, false

load "deploy/assets"

set :application, "listenlaterapp.com"
set :repository,  "git@github.com:beautifulcode/listenlater.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#set :domain, "listenlater.beautifulco.de"
set :user, 'deploy'
set :domain, "listenlaterapp.com"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run

set :deploy_to, "/var/www/apps/#{application}/"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

   # only compile if needed
  #namespace :assets do
    #task :precompile, :roles => :web, :except => { :no_release => true } do
      #from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        #run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      #else
        #logger.info "Skipping asset pre-compilation because there were no asset changes"
      #end
    #end
  #end
 end


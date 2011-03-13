if @capistrano
	puts "==> Capistrano".magenta

	puts "   --> Creating deploy file".magenta
	file "config/deploy.rb", do
	<<-RUBY
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

load 'deploy' if respond_to?(:namespace)

set :rake, "/usr/local/bin/rake"
set :bundle_cmd, "/usr/local/bin/bundle"

set :application, "application_name"
set :scm, 'git'
set :repository, "git@github.com:username/\#{application_name}.git"

# Settings
set :use_sudo,       false
set :group_writable, false      
set :keep_releases,  4

set :asset_list, ["public/system"]

desc "Keep only 4 releases"
task :after_deploy do
  deploy::cleanup
end

# passenger config
namespace :passenger do
    desc "Restart the web server"
    task :restart, :roles => :app do
        run "touch \#{current_release}/tmp/restart.txt"
    end

    [:start, :stop].each do |t|
        desc "\#{t} task is a no-op with passenger"
        task t, :roles => :app do ; end
    end
end

namespace :deploy do
  desc "Restart your application"
  task :restart do
      passenger::restart
  end

  desc "Start your application"
  task :start do
      passenger::start
  end

  desc "Stop your application"
  task :stop do
      passenger::stop
  end

end

namespace :assets do
  task :symlink, :roles => :app do
    assets.create_dirs

      asset_list.each do |name|
        run "rm -rf \#{release_path}/\#{name}"
        run "ln -nfs \#{shared_path}/\#{name} \#{release_path}/\#{name}"
      end
    end

  task :create_dirs, :roles => :app do
    asset_list.each do |name|
      run "mkdir -p \#{shared_path}/\#{name}"
    end
  end
end

after('deploy:update_code') do
  assets.symlink
end

begin
  require 'capfire/capistrano'
rescue Object
  #Don't force other users to install Capfire.
end

require 'hoptoad_notifier/capistrano'
	RUBY
	end

	puts "   --> Creating production deploy file".magenta
	file "config/deploy/production.rb", do
	<<-RUBY
role :app, "domain.name"
role :web, "domain.name"
role :db,  "domain.name", :primary => true

set :rails_env, "production"
set :user,			"user_name_on_server"
set :deploy_to, "/var/www/website/dir/on/server"
set :branch,		"master"
	RUBY
	end
end

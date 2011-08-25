require 'bundler/capistrano'
require 'thinking_sphinx/deploy/capistrano'

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => false, :port => 222 }

set :application, "prometheus2.0"
set :repository,  "git://github.com/biow0lf/prometheus2.0.git"
set :scm, :git
set :branch, :master
set :user, "prometheusapp"
set :group, "prometheusapp"
set :deploy_via, :remote_cache
# set :git_shallow_clone, 1
set :use_sudo, false

set :deploy_to, "/home/prometheusapp/www"

role :app, "packages.altlinux.org"
role :web, "packages.altlinux.org"
role :db, "packages.altlinux.org", :primary => true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
# end passenger stuff

after 'deploy:update_code', 'deploy:symlink_all'

namespace :deploy do
  desc "Symlinks all needed files"
  task :symlink_all, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{deploy_to}/shared/config/redis.yml #{release_path}/config/redis.yml"
    run "cp -f #{deploy_to}/shared/config/initializers/devise.rb #{release_path}/config/initializers/"
    run "cp -f #{deploy_to}/shared/config/initializers/secret_token.rb #{release_path}/config/initializers/"
    # precompile the assets
    run "cd #{current_path} && bundle exec rake assets:precompile"
  end
end

task :before_update_code, :roles => [:app] do
  thinking_sphinx.stop
end

task :after_update_code, :roles => [:app] do
  thinking_sphinx.configure
  thinking_sphinx.start
end

namespace :redis do
  desc "Start the Redis server"
  task :start do
    run "/usr/sbin/redis-server /home/prometheusapp/www/shared/config/redis.conf"
  end

  desc "Stop the Redis server"
  task :stop do
    run 'echo "SHUTDOWN" | nc localhost 6379'
  end
end

namespace :memcached do
  desc "Start the memcached server"
  task :start do
    run '/usr/bin/memcached -d -m 128'
  end
end

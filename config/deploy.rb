# frozen_string_literal: true

lock '3.11.0'

set :application, 'prometheus2.0'
set :deploy_user, 'apache'

set :rbenv_type, :user
# set :rbenv_ruby, File.read('.ruby-version').strip

set :branch, ENV['BRANCH'] || "master"

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/secrets.yml',
                      'config/newrelic.yml',
                      'config/database.yml',
                      'config/initializers/devise.rb'

# Default value for linked_dirs is []
append :linked_dirs, 'log',
                     'tmp/pids',
                     'tmp/cache',
                     'tmp/sockets',
                     'public/system'

# Default value for keep_releases is 5
set :keep_releases, 3

set :bundle_jobs, 4
set :bundle_binstubs, -> { shared_path.join('bin') }

set :nginx_domains, "packages.altlinux.org"
set :nginx_service_path, "/etc/init.d/nginx"
set :nginx_sites_available_dir, "/etc/nginx/sites-available.d"
set :nginx_sites_enabled_dir, "/etc/nginx/sites-enabled.d"
set :nginx_application_name, "#{fetch :application}-#{fetch :stage}"
set :nginx_template, "#{current_path}/config/environments/#{fetch :stage}/nginx.conf.erb"
set :app_server_socket, "#{shared_path}/sockets//puma-#{fetch :application}.sock"
set :app_server_host, "localhost"
set :app_server_port, 80

# set :rvm_type, :user                      # Defaults to: :auto
# set :rvm_ruby_version, '2.3.4@dneslov'    # Defaults to: 'default'
# set :rvm_custom_path, '~/.rvm'          # only needed if not detected
set :rvm_roles, %i[app web]

namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # before 'deploy:setup_config', 'nginx:remove_default_vhost'
  before 'deploy:finishing', 'nginx:site:add'
  before 'deploy:finishing', 'nginx:site:enable'
  after 'deploy:finishing', 'nginx:restart'
  after 'deploy:finished', 'deploy:restart'
  # after :finishing, 'systemd:restart'
end

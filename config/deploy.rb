# frozen_string_literal: true

lock '3.11.0'

set :application, 'prometheus2.0'
set :repo_url, 'git://github.com/biow0lf/prometheus2.0.git'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :branch, :master

set :deploy_to, '/home/prometheusapp/www'

set :rails_env, 'production'

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
set :linked_files, fetch(:linked_files, []).push('.env',
                                                 'config/newrelic.yml',
                                                 'config/initializers/devise.rb')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log',
                                               'tmp/pids',
                                               'tmp/cache',
                                               'tmp/sockets',
                                               'vendor/bundle',
                                               'public/system')

# Default value for keep_releases is 5
set :keep_releases, 3

set :bundle_jobs, 4
set :bundle_binstubs, -> { shared_path.join('bin') }

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # after :finishing, 'systemd:restart'
end

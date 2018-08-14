# frozen_string_literal: true

set :repo_url, 'git://10.10.3.49/prometheus2.0.git'

set :deploy_to, '/var/www/prometheus2.0'

set :rails_env, 'production'

server '10.10.3.163', user: 'apache', roles: ['app', 'db', 'web']

set :ssh_options, port: 22

set :rvm_type, :system

set :app_server_host, "10.10.3.163"

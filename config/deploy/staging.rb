# frozen_string_literal: true

set :repo_url, 'git://10.10.3.49/prometheus2.0.git'

set :deploy_to, '/var/www/prometheus2.0'

set :rails_env, 'staging'

server '10.10.3.49', user: 'apache', roles: ['app', 'db', 'web']

set :ssh_options, port: 22

set :rvm_type, :user

set :app_server_host, "staging.office.basealt.ru"
#set :app_server_host, "10.10.3.49"

set :nginx_domains, "staging.office.basealt.ru"

# frozen_string_literal: true

set :repo_url, 'git://10.10.3.49/srv/git/pub/prometheus2.0.git'

set :deploy_to, '/var/www/prometheus2.0'

set :rails_env, 'staging'

server '10.10.3.49', user: 'apache', roles: ['app', 'db', 'web']

set :ssh_options, port: 22

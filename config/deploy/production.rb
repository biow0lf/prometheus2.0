# frozen_string_literal: true

set :repo_url, 'git://github.com/biow0lf/prometheus2.0.git'

set :deploy_to, '/home/prometheusapp/www'

set :rails_env, 'production'

server 'prometheus.altlinux.org', user: 'prometheusapp', roles: ['app', 'db', 'web']

set :ssh_options, port: 222

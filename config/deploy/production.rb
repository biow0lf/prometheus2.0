# frozen_string_literal: true

server 'prometheus.altlinux.org', user: 'prometheusapp', roles: ['app', 'db', 'web']

set :ssh_options, port: 222

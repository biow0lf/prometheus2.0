server 'prometheus.altlinux.org', user: 'prometheusapp', roles: %w[app db web]

set :ssh_options, port: 222

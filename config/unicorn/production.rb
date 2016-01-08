# based on https://github.com/tablexi/capistrano3-unicorn/blob/master/examples/unicorn.rb

# paths
app_path = '/home/prometheusapp/www'
working_directory "#{ app_path }/current"
pid               "#{ app_path }/current/tmp/pids/unicorn.pid"

# listen
listen '/tmp/packages.altlinux.org.socket', backlog: 64

# logging
stderr_path 'log/unicorn.stderr.log'
stdout_path 'log/unicorn.stdout.log'

# workers
worker_processes 8

# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{ app_path }/current/Gemfile"
end

# preload
preload_app true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 600

# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

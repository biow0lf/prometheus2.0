# encoding: utf-8

# Backup
# Generated Template
#
# For more information:
#
# View the Git repository at https://github.com/meskyanichi/backup
# View the Wiki/Documentation at https://github.com/meskyanichi/backup/wiki
# View the issue log at https://github.com/meskyanichi/backup/issues
#
# When you're finished configuring this configuration file,
# you can run it from the command line by issuing the following command:
#
# $ backup -t my_backup [-c <path_to_configuration_file>]

database_yml = 'config/database.yml'
RAILS_ENV    = ENV['RAILS_ENV'] || 'development'

require 'yaml'
config = YAML.load_file(database_yml)

Backup::Model.new(:db_backup, 'Database Backup') do
  database PostgreSQL do |db|
    db.name               = config[RAILS_ENV]["database"]
    db.username           = config[RAILS_ENV]["username"]
    db.password           = config[RAILS_ENV]["password"]
    db.host               = config[RAILS_ENV]["host"]
    db.port               = config[RAILS_ENV]["port"]
    db.skip_tables        = []
  end

#  database Redis do |db|
#    db.name               = "my_database_name"
#    db.path               = "/usr/local/var/db/redis"
#    db.password           = "my_password"
#    db.host               = "localhost"
#    db.port               = 5432
#    db.socket             = "/tmp/redis.sock"
#    db.additional_options = []
#    db.invoke_save        = true
#    # Optional: Use to set the location of this utility
#    #   if it cannot be found by name in your $PATH
#    # db.redis_cli_utility = '/opt/local/bin/redis-cli'
#  end

#  store_with RSync do |server|
#    server.username = nil
#    server.password = nil
#    server.ip       = nil
#    server.port     = nil
#    server.path     = '~/backups/'
#    server.local    = true # true if you want to store locally
#  end

  store_with Local do |local|
    local.path = '~/backups/'
    local.keep = 10
  end

  compress_with Bzip2 do |compression|
    compression.best = true
    compression.fast = false
  end
end


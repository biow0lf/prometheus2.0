# frozen_string_literal: true

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/scm/git'
require 'capistrano/nginx'

require 'capistrano/rvm'
require 'capistrano/rake'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/faster_assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'whenever/capistrano'

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma  # Default puma tasks

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

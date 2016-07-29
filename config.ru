# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Health

if ENV['RAILS_ENV'] == 'production'
  # require 'unicorn/oob_gc'
  # GC.disable
  # use Unicorn::OobGC, 10
end


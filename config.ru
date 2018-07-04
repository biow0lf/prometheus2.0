# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.
$stdout.puts "{config.ru}: ENV[RAILS_ENV]: #{ENV['RAILS_ENV']}"

require_relative 'config/environment'

run Rails.application

# For New Relic health check
if Rails.env.production?
  use Rack::Health
end

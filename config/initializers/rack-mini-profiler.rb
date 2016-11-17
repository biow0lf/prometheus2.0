# rubocop:disable Style/FileName

require 'rack-mini-profiler'

Rack::MiniProfilerRails.initialize!(Rails.application)
Rack::MiniProfiler.config.position = 'right'

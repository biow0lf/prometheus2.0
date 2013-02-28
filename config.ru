# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Prometheus20::Application

#require 'unicorn/oob_gc'
#
#use Unicorn::OobGC, 10
#
## Unicorn self-process killer
#require 'unicorn/worker_killer'
#
## Max requests per worker
#use Unicorn::WorkerKiller::MaxRequests, 10240 + Random.rand(10240)
#
## Max memory size (RSS) per worker
#use Unicorn::WorkerKiller::Oom, (96 + Random.rand(32)) * 1024**2

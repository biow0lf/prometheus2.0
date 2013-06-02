# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Prometheus20::Application

#require 'unicorn/oob_gc'
#GC.disable
#use Unicorn::OobGC, 10

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max requests per worker
use Unicorn::WorkerKiller::MaxRequests, 3072, 4096

# Max memory size (RSS) per worker
use Unicorn::WorkerKiller::Oom, (128*(1024**2)), (196*(1024**2))

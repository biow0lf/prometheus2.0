REDIS_CONFIG = YAML.load(File.read(File.dirname(__FILE__) + "/../redis.yml")).symbolize_keys
$redis = Redis.new(REDIS_CONFIG)

require 'redis/objects'
Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)

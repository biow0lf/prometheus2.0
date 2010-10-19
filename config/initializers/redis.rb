REDIS_CONFIG = YAML.load(File.read(File.dirname(__FILE__) + "/../redis.yml")).symbolize_keys
$redis = Redis.new(REDIS_CONFIG)

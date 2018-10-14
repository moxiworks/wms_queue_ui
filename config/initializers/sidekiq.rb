Rails.application.config.redis_pools = {}

Rails.application.config.redis.each do |conf_key, app_conf|
  Rails.application.config.redis_pools[conf_key] =
      {
          redis: ConnectionPool.new { Redis.new( url: "redis://#{app_conf['host']}:#{app_conf['port']}" ) },
          apps: app_conf['applications']
      }

end

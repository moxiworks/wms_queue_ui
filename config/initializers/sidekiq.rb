require 'sidekiq'

filename = Rails.env.development? ? "redis.yml.secret" : "redis.yml"
redis_conf = YAML::load(File.open(File.join(Rails.root,"config", filename)))[Rails.env]


Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_conf['host']}:#{redis_conf['port']}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_conf['host']}:#{redis_conf['port']}" }
end

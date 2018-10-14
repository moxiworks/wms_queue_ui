Rails.application.routes.draw do


  count = 1
  Rails.application.config.redis_pools.each do |name, pool|
    require "sidekiq#{count}"
    require "sidekiq#{count}/web"
    sk = Kernel.const_get("Sidekiq#{count}")

    sk.configure_client do |config|
      config.redis = pool[:redis]
    end
    pool[:apps].each do |app|
      mount sk::Web =>  "/#{app}", as: app
    end

    count += 1
  end

end

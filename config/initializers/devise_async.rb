# Supported options: :resque, :sidekiq, :delayed_job, :queue_classic, :torquebox, :backburner
Devise::Async.backend = :sidekiq

if Rails.env.production?
  Devise::Async.enabled = true
else
  Devise::Async.enabled = false
end


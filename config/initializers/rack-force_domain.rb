# frozen_string_literal: true

if Rails.env.production?
  Rails.application.config.middleware.use Rack::ForceDomain, 'packages.altlinux.org'
end

# rubocop:disable Style/FileName
if Rails.env.production?
  Rails.application.config.middleware.use Rack::ForceDomain, 'packages.altlinux.org'
end

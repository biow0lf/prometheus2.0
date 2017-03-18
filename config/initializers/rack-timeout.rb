# rubocop:disable Style/FileName
if defined? Rack::Timeout
  Rack::Timeout.service_timeout = 15
end

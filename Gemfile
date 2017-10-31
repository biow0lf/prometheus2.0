source 'https://rubygems.org'

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.10'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'rack-health'
gem 'rack-force_domain', group: :production
gem 'exception_notification', group: :production
gem 'rails-i18n'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'rack-mini-profiler', require: false
gem 'dotenv-rails'
gem 'redis-objects'
gem 'pghero'
gem 'pg_query'
gem 'http_logger'

gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'
gem 'draper'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', require: false
gem 'whenever', require: false
gem 'awesome_nested_set'
gem 'mysql2' # for thinking-sphinx
gem 'thinking-sphinx'
gem 'sitemap_generator'
gem 'rouge'
# gem 'github-linguist'
gem 'swagger-blocks'
gem 'rack-cors', require: 'rack/cors'
gem 'sidekiq', require: false
# gem 'oink'
gem 'rectify'
gem 'posix-spawn', require: false
gem 'cocaine', require: false
gem 'browser'
gem 'http_accept_language'
# gem 'molinillo', require: false

group :production, :development do
  gem 'redis'
end

group :production do
  gem 'newrelic_rpm'
  gem 'lograge'
  gem 'rack-timeout'
  gem 'dalli'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  gem 'bullet'
  # https://github.com/net-ssh/net-ssh/issues/478
  gem 'bcrypt_pbkdf', require: false # for rbnacl-libsodium
  gem 'rbnacl', '< 4.0', require: false # for rbnacl-libsodium
  gem 'rbnacl-libsodium', require: false # for ssh-ed25519 support
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rbenv-install', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano3-puma', require: false
  # gem 'xray-rails'
  gem 'rubocop', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'mry', require: false
  gem 'brakeman', require: false
  # gem 'lol_dba'
  gem 'squasher', require: false
  gem 'bundler-audit', require: false
  gem 'license_finder', require: false
  gem 'active_record_doctor'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'awesome_print', require: 'ap'
  gem 'faker'
  gem 'factory_bot_rails'
end

group :test do
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-matchers-controller_filters'
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'database_rewinder'
  gem 'webmock', require: false
  gem 'fakeredis'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end

source 'https://rubygems.org'

ruby '2.2.2'

gem 'bundler', '>= 1.7.0'

gem 'rails', '4.2.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
  gem 'redcarpet'
end

gem 'rake', require: false

group :postgresql do
  gem 'pg'
end

group :sqlite do
  gem 'sqlite3'
end

gem 'rack-health'
gem 'rack-timeout'
gem 'devise'
gem 'redis-objects'
gem 'kaminari'
gem 'draper'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', require: false
gem 'whenever', require: false
gem 'awesome_nested_set'
gem 'mysql2' # for thinking-sphinx
gem 'thinking-sphinx'
gem 'sitemap_generator'
gem 'coderay'
# gem 'rack-rewrite'
gem 'rack-mini-profiler', require: false
gem 'swagger-blocks'

group :production, :development, :staging do
  gem 'redis'
end

group :production, :staging do
  gem 'dalli'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rack-force_domain'
  gem 'exception_notification'
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  gem 'lograge'
end

group :staging do
  gem 'active_sanity'
end

group :development do
  gem 'sandi_meter', require: false
  gem 'rails-erd', require: false
  gem 'quiet_assets'
  gem 'bullet'
  gem 'capistrano', '2.15.5', require: false
  gem 'capistrano_colors', require: false
  gem 'rubocop', require: false
  gem 'flog', require: false
  gem 'brakeman', require: false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'pry'
  gem 'pry-rails'
  gem 'awesome_print', require: 'ap'
  gem 'faker'
  gem 'factory_girl_rails'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'airborne'
  gem 'capybara-email'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'fakeweb'
  # TODO: replace fakeweb with webmock
  gem 'webmock', require: false
  gem 'fakeredis'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end

source 'https://rubygems.org'

gem 'rails', '~> 5.1.0.beta1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'

gem 'puma'

group :postgresql do
  gem 'pg'
end

group :sqlite do
  gem 'sqlite3'
end

gem 'rack-health'
gem 'devise'
gem 'redis-objects'
gem 'kaminari'
gem 'draper', '~> 3.0.0.pre1'
# gem 'good_migrations'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', require: false
gem 'whenever', require: false
gem 'awesome_nested_set'
gem 'mysql2' # for thinking-sphinx
gem 'thinking-sphinx'
gem 'chewy'
gem 'sitemap_generator'
gem 'rouge'
# gem 'github-linguist'
gem 'rack-mini-profiler', require: false
gem 'swagger-blocks'
gem 'rack-cors', require: 'rack/cors'
gem 'sidekiq'
# gem 'oink'
gem 'rectify'
gem 'cocaine'
gem 'browser'
gem 'http_accept_language'

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
  gem 'lograge'
  gem 'rack-timeout'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-faster-assets'
  gem 'capistrano3-puma'
  # gem 'xray-rails'
  # rubocop version locked due config. Update rubocop config on gem update.
  gem 'rubocop', '0.46.0', require: false
  gem 'brakeman', require: false
  # gem 'lol_dba'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'awesome_print', require: 'ap'
  gem 'faker'
  gem 'factory_girl_rails'
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
  gem 'database_cleaner'
  gem 'fakeweb'
  # TODO: replace fakeweb with webmock
  gem 'webmock', require: false
  gem 'fakeredis'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end

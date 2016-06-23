source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc2', '< 5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'

# gem 'puma', '~> 3.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rake', require: false

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
gem 'draper', git: 'https://github.com/drapergem/draper.git', branch: 'rails-5'
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
# gem 'rack-rewrite'
gem 'rack-mini-profiler', require: false
gem 'activerecord-colored_log_subscriber'
gem 'swagger-blocks'
gem 'rack-cors', require: 'rack/cors'
gem 'public_activity'
gem 'rails-observers', git: 'https://github.com/rails/rails-observers.git', branch: 'master'
gem 'sidekiq'
# gem 'oink'
gem 'rectify'

group :production, :development, :staging do
  gem 'redis'
end

group :production, :staging do
  gem 'dalli'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rack-force_domain'
  gem 'exception_notification', git: 'https://github.com/smartinez87/exception_notification.git', branch: 'rails5'
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  gem 'lograge'
  gem 'rack-timeout'
end

group :staging do
  gem 'active_sanity'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'quiet_assets'
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-faster-assets'
  gem 'capistrano3-unicorn'
  gem 'capistrano-db-tasks', require: false
  # gem 'xray-rails'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'lol_dba'
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

source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'

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
# WORKAROUND for draper
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml.git', branch: 'master'
gem 'draper'
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
gem 'rack-timeout'
gem 'public_activity'
gem 'rails-observers', git: 'https://github.com/rails/rails-observers.git', branch: 'master'
gem 'sidekiq'
# gem 'oink'

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
end

group :puma do
  gem 'puma'
end

group :staging do
  gem 'active_sanity'
end

group :development do
  gem 'quiet_assets'
  gem 'bullet'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-faster-assets'
  gem 'capistrano3-unicorn'
  gem 'airbrussh', require: false
  gem 'capistrano-db-tasks', require: false
  # gem 'xray-rails'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
end

group :development, :test do
  # gem 'rspec'
  # gem 'rspec-rails'

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end

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

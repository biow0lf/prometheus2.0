source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'rake'

gem 'pg'
gem 'devise'
#gem 'recaptcha', :require => 'recaptcha/rails'
gem 'ransack'
gem 'squeel'
gem 'kaminari', :git => 'git://github.com/amatsuda/kaminari.git'
gem 'fast_gettext', '>=0.4.8'
gem 'gettext_i18n_rails'
gem 'gettext', '>=1.9.3', :require => false
gem 'whenever', :require => false
gem 'nested_set'
gem 'thinking-sphinx'
gem 'brewdler', :require => false
gem 'sitemap_generator'
gem 'globalize3'
gem 'jsonify-rails'
gem 'unicorn'

group :production, :development, :staging do
  gem 'redis'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

gem 'jquery-rails'

group :production do
  gem 'memcache-client'
  gem 'newrelic_rpm'
  gem 'rack-force_domain'
  gem 'exception_notification'
end

group :staging do
  gem 'memcache-client'
  gem 'active_sanity'
end

group :development do
  gem 'silent-postgres'
  gem 'capistrano', :require => false
  gem 'capistrano_colors', :require => false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'ruby-debug19'
  gem 'guard'
  gem 'rb-fsevent', :require => false
  gem 'growl', :require => false
  gem 'rb-inotify', :require => false
  gem 'libnotify', :require => false
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  gem 'capybara'
  # gem 'ffaker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'launchy'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'fakeweb'
  gem 'fakeredis'
  gem 'factory_girl_rails'
  gem 'simplecov', :require => false
end

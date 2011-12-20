source 'http://rubygems.org'

gem 'rails', '3.2.0.rc1'

gem 'rake'

gem 'pg'
gem 'devise'
#gem 'recaptcha', :require => 'recaptcha/rails'
gem 'squeel'
gem 'kaminari', :git => 'git://github.com/amatsuda/kaminari.git'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', :require => false
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
  gem 'sass-rails'
  gem 'coffee-rails'
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
  gem 'guard'
  gem 'rb-readline'
  gem 'rb-fsevent', :require => false
  gem 'growl', :require => false
  gem 'rb-inotify', :require => false
  gem 'libnotify', :require => false
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :development, :test do
  gem 'rspec', '2.8.0.rc2'
  gem 'rspec-rails', '2.8.0.rc2'
  gem 'ruby-debug19'
end

group :test do
  gem 'capybara'
  # gem 'ffaker'
  gem 'rspec-rails', '2.8.0.rc2'
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

source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

gem 'pg'
gem 'haml'
gem 'devise'
#gem 'recaptcha', :require => 'recaptcha/rails'
gem 'redis'
gem 'meta_search', '1.1.0.pre2'
gem 'squeel'
gem 'kaminari'
gem 'fast_gettext', '>=0.4.8'
gem 'gettext_i18n_rails'
gem 'gettext', '>=1.9.3', :require => false
gem 'whenever', :require => false
gem 'nested_set'
gem 'thinking-sphinx'
gem 'brewdler', :require => false
gem 'wirb', :require => false
gem 'sitemap_generator'
gem 'globalize3'
gem 'jsonify-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'jquery-rails'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'memcache-client'
  gem 'newrelic_rpm'
  gem 'rack-maintenance', :require => 'rack/maintenance'
  gem 'rack-force_domain'
  gem 'exception_notification'
end

group :staging do
  gem 'memcache-client'
  gem 'active_sanity'
end

group :development do
  gem 'silent-postgres'
  # gem 'rack-webconsole'
end

group :development, :test do
  gem 'ruby-debug19'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rcov', :require => false
  gem 'stepdown', :require => false
  gem 'guard'
  gem 'rb-fsevent', :require => false
  gem 'growl', :require => false
  # linux part is not tested
  gem 'rb-inotify', :require => false
  gem 'libnotify', :require => false
  gem 'guard-test'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-livereload'
end

group :test do
  gem 'capybara'
  gem 'ffaker'
  gem 'fabrication'
  gem 'shoulda'
  gem 'email_spec'
  gem 'json_spec'
  gem 'launchy'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

source 'http://rubygems.org'

gem 'rails', '3.0.9'
gem 'pg'
gem 'haml'
gem 'devise'
#gem 'recaptcha', :require => 'recaptcha/rails'
gem 'redis'
gem 'meta_search'
gem 'meta_where'
gem 'kaminari'
gem 'fast_gettext', '>=0.4.8'
gem 'gettext_i18n_rails'
gem 'gettext', '>=1.9.3', :require => false
gem 'whenever', :require => false
gem 'exception_notification', :git => 'git://github.com/smartinez87/exception_notification.git'
gem 'nested_set'
gem 'thinking-sphinx'
gem 'rack-force_domain'
gem 'brewdler', :require => false
gem 'wirb', :require => false

group :production do
  gem 'memcache-client'
  gem 'newrelic_rpm'
end

group :staging do
  gem 'memcache-client'
  gem 'active_sanity'
end

group :development do
  gem 'silent-postgres'
end

group :development, :test do
  gem 'ruby-debug19'
  gem 'sqlite3'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rcov', :require => false
  gem 'stepdown', :require => false
  gem 'guard'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl', :require => false if RUBY_PLATFORM =~ /darwin/i
  # linux part is not tested
  gem 'rb-inotify', :require => false if RUBY_PLATFORM =~ /linux/i
  gem 'libnotify', :require => false if RUBY_PLATFORM =~ /linux/i
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-livereload'
end

group :test do
  gem 'capybara'
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'remarkable_activerecord', :git => 'git://github.com/jeroenvandijk/remarkable.git'
  gem 'email_spec'
  gem 'launchy'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

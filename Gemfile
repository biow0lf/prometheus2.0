source 'http://rubygems.org'

gem 'rails', '3.0.9.rc5'
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
  gem 'sqlite3-ruby'
  gem 'rspec'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  # gem 'syntax' # for TextMate syntax highlight
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'remarkable_activerecord', :git => 'git://github.com/jeroenvandijk/remarkable.git'
  gem 'email_spec'
  # opening pages in browser
  gem 'launchy'
  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

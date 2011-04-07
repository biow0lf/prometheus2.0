source 'http://rubygems.org'

gem 'rails', '3.0.6'
gem 'pg'
gem 'haml'
gem 'devise'
#gem 'recaptcha', :require => 'recaptcha/rails'
gem 'redis'
gem 'SystemTimer' # for redis and ruby 1.8
gem 'meta_search'
gem 'meta_where'
gem 'kaminari'
gem 'fast_gettext', '>=0.4.8'
gem 'gettext_i18n_rails'
gem 'gettext', '>=1.9.3', :require => false
gem 'whenever', :require => false
gem 'newrelic_rpm'
gem 'exception_notification', :require => 'exception_notifier', :git => 'git://github.com/smartinez87/exception_notification.git'
gem 'rails_db_dump'
gem 'memcache-client'
gem 'nested_set'
gem 'thinking-sphinx', :require => 'thinking_sphinx'
gem 'active_sanity'

group :development, :test do
  gem 'ruby-debug'
  gem 'sqlite3-ruby'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'syntax' # for TextMate syntax highlight
  gem 'ffaker'
  gem 'factory_girl_rails'
  # for gettext & haml
  gem 'ruby_parser'
  gem 'hpricot'
  # opening pages in browser
  gem 'launchy'
  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

group :development do
  gem 'haml-rails'
  gem 'silent-postgres'
end

group :test do
  gem 'autotest'
  gem 'shoulda'
end

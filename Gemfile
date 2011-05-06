source 'http://rubygems.org'

gem 'rails', '3.0.7'
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
gem 'newrelic_rpm'
gem 'exception_notification', :git => 'git://github.com/smartinez87/exception_notification.git'
gem 'nested_set'
gem 'thinking-sphinx'

group :production do
  gem 'memcache-client'
end

group :staging do
  gem 'memcache-client'
  gem 'active_sanity'
end

group :development, :test do
  gem 'ruby_core_source' # hack for linecache19 0.5.12 building under altlinux
  gem 'ruby-debug19'
  gem 'sqlite3-ruby'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'syntax' # for TextMate syntax highlight
  gem 'ffaker'
  gem 'factory_girl_rails'
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
  gem 'email_spec'
end

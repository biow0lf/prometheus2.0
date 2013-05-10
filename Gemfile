source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0.rc1'
gem 'protected_attributes'
gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'rake', require: false

gem 'pg', group: :postgresql
gem 'mysql2', '0.3.12b6', group: :mysql
gem 'sqlite3', group: :sqlite

gem 'devise', '3.0.0.rc'
# TODO: gem 'squeel'
gem 'kaminari'
gem 'everywhere' # TODO: check this later, maybe remove it
gem 'nested_set'
gem 'mysql2', '0.3.12b6' # for thinking-sphinx
gem 'thinking-sphinx'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', require: false
# TODO: gem 'coderay'

gem 'brewdler', require: false
gem 'whenever', require: false
gem 'sitemap_generator'
gem 'backup', require: false

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# TODO: remove this in flavor of ruby .to_json
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'pry'
  gem 'rspec-rails'
  gem 'hirb'
  gem 'wirb'
end

group :test do
  gem 'factory_girl_rails'
  gem 'fakeweb'
  gem 'fakeredis'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec'

# TODO: check this later
#  # gem 'ffaker'
#  gem 'launchy'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'xray-rails' # ctrl-shift-x :)
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'

  # gem 'rails-erd'
  # gem 'meta_request'
  # gem 'rb-fsevent', require: false
  # gem 'growl', require: false
  # gem 'rb-inotify', '~> 0.9', require: false
  # gem 'libnotify', require: false

  # capistrano stuff
  gem 'capistrano', require: false
  gem 'capistrano_colors', require: false
end

group :production, :development, :staging do
  gem 'redis'
end

group :production do
  gem 'dalli'
  gem 'newrelic_rpm'
#  gem 'newrelic-redis'
  gem 'rack-force_domain'
  gem 'exception_notification'
  gem 'unicorn'
  gem 'unicorn-worker-killer'
end

group :staging do
  gem 'dalli'
  gem 'active_sanity'
end

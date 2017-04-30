source 'https://rubygems.org'

gem 'rails', '~> 5.1.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'rack-health'
gem 'rack-force_domain', group: :production
gem 'exception_notification', group: :production
gem 'rails-i18n'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'rack-mini-profiler', require: false
gem 'dotenv-rails'
gem 'redis-objects'
gem 'pghero'
gem 'pg_query'

gem 'devise', git: 'https://github.com/plataformatec/devise', branch: 'master'
gem 'draper', '~> 3.0.0.pre1'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'gettext', require: false
gem 'whenever', require: false
gem 'awesome_nested_set', git: 'https://github.com/biow0lf/awesome_nested_set', branch: 'master'
gem 'mysql2' # for thinking-sphinx
gem 'thinking-sphinx'
gem 'chewy'
gem 'sitemap_generator'
gem 'rouge'
# gem 'github-linguist'
gem 'swagger-blocks'
gem 'rack-cors', require: 'rack/cors'
gem 'sidekiq'
# gem 'oink'
gem 'rectify'
gem 'cocaine'
gem 'browser'
gem 'http_accept_language'

group :production, :development do
  gem 'redis'
end

group :production do
  gem 'newrelic_rpm'
  gem 'lograge'
  gem 'rack-timeout'
  gem 'dalli'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bullet'
  # https://github.com/net-ssh/net-ssh/issues/478
  gem 'bcrypt_pbkdf' # for rbnacl-libsodium
  gem 'rbnacl', '< 4.0' # for rbnacl-libsodium
  gem 'rbnacl-libsodium' # for ssh-ed25519 support
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-install'
  gem 'capistrano-faster-assets'
  gem 'capistrano3-puma'
  # gem 'xray-rails'
  # rubocop version locked due config. Update rubocop config on gem update.
  gem 'rubocop', '0.48.1', require: false # DONE
  gem 'brakeman', require: false
  # gem 'lol_dba'
end

group :development, :test do
  gem 'rspec-rails' # DONE
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

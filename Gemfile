source 'https://rubygems.org'
ruby '2.2.2'

gem 'sinatra', require: 'sinatra/base'
gem 'puma'
gem 'json'
gem 'dotenv'

group :development do
  gem 'rubocop'
end

group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
end

group :production do
  gem 'newrelic_rpm'
  gem 'sentry-raven'
end

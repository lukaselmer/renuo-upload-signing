require 'bundler'
require 'sinatra'
require 'dotenv'
require 'json'
require File.dirname(__FILE__) + '/models/upload_policy.rb'
require File.dirname(__FILE__) + '/models/api_keys.rb'
Bundler.require
Dotenv.load('config/.env')

configure do
  set :api_keys, ApiKeys.new(ENV['API_KEYS'])
end

post '/upload_policy' do
  content_type :json
  if settings.api_keys.check(params[:api_key])
    upload_policy = UploadPolicy.new(api_key.app_name)
    status 200
    body "#{upload_policy.form_data.to_json}"
  else
    status 403
    body 'Invalid API key...'
  end
end

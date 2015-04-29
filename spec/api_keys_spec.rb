require File.dirname(__FILE__) + '/../models/api_keys.rb'
require File.dirname(__FILE__) + '/../models/api_key.rb'
require File.dirname(__FILE__) + '/../app.rb'
require 'rack/test'

def app
  Sinatra::Application
end

RSpec.describe 'ApiKeys', type: :model do
  include Rack::Test::Methods
  context 'create api_keys array from env vars' do

    let!(:api_keys) { ApiKeys.new('{"key":"12345678","app_name":"foobar","environment": "test"}') }

    it 'generates the api_keys array from a string when initializing the model' do
      test_key = ApiKey.new('12345678', 'foobar', 'test')

      expect(api_keys.api_keys.first.key).to eq(test_key.key)
      expect(api_keys.api_keys.first.app_name).to eq(test_key.app_name)
      expect(api_keys.api_keys.first.environment).to eq(test_key.environment)
    end

    it 'sees if the check method return false if an unknown key is posted' do
      expect(api_keys.check('87654321')).to be_falsey
    end

    it 'sees if the the check method returns the api_key if a known key is posted' do
      expect(api_keys.check('12345678')).to be_truthy
      expect(api_keys.check('12345678').class).to be(ApiKey)
    end

    it 'checks that an ok status is returned when posting a know api key to /generate_policy' do
      post '/generate_policy', params={api_key: '12345678'}
      expect(last_response.status).to eq(200)
    end

    it 'checks that a 403 status is returned when posting an unknown api key to /generate_policy' do
      post '/generate_policy', params={api_key: 'foobar'}
      expect(last_response.status).to eq(403)
    end
  end
end
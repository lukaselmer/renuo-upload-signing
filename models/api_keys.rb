require File.dirname(__FILE__) + '/api_key.rb'
require 'dotenv'
require 'json'
Dotenv.load('config/.env')

class ApiKeys
  attr_reader :api_keys

  def initialize(keys_string)
    @api_keys = extract_keys_from_string(keys_string) 
  end

  def extract_keys_from_string(keys_string)
    keys_string.split(';').map do |key_params|
      key = JSON.parse(key_params) rescue next
      ApiKey.new(key['key'], key['app_name'], key['environment']) if validate_api_key_hash(key)
    end.compact
  end

  def find_api_key(key)
    @api_keys.find { |api_key| api_key.key.eql? key }
  end

  def validate_api_key_hash(api_key_hash)
    api_key_hash['key'] && api_key_hash['app_name'] && api_key_hash['environment']
  end
end

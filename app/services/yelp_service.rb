require './config/environment'
require 'json'

class YelpService < Sinatra::Base
  def self.fetch_parsed_json(category, location)
    conn = Faraday.new('https://api.yelp.com') do |f|
      f.headers['Authorization'] = ENV['YELP_API_KEY']
    end
    response = conn.get('/v3/businesses/search') do |f|
      f.params[:location] = location
      f.params[:categories] = category
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end

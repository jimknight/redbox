class MoviesController < ApplicationController

  require 'open-uri'
  require 'json'
  def list
    redbox_api_key = ENV["REDBOX_API_KEY"]
    url = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}&retailer=giant&count=1"
    # request = open(url)
    # binding.pry
    # result = Nokogiri.XML(open(url).read)
    result = JSON.parse(open(url,"Accept" => "application/json").read)
    binding.pry
  end

end

class RedboxApi < ActiveRecord::Base

  @@redbox_api_key = ENV["REDBOX_API_KEY"]

  def self.get_stores_by_zip(zip)
    url = "https://api.redbox.com/v3/inventory/stores/postalcode/#{zip}?apiKey=#{@@redbox_api_key}"
    return JSON.parse(open(url,"Accept" => "application/json").read)
  end

end

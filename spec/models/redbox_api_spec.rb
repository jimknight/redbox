require 'spec_helper'

describe RedboxApi do
  describe "get_stores_by_zip" do
    it "should return json given a zip" do
      zip = "20176"
      redbox_api_key = ENV["REDBOX_API_KEY"]
      stub_request(:get, "https://api.redbox.com/v3/inventory/stores/postalcode/#{zip}?apiKey=#{redbox_api_key}").
         with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"store": {"title": "food lion"}}', :headers => {})
      RedboxApi.get_stores_by_zip(zip).should_not be_nil
    end
  end
end
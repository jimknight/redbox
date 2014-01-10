require 'spec_helper'

describe RedboxApi do
  describe "get_stores_by_zip" do
    it "should return json given a zip" do
      redbox_api_key = ENV["REDBOX_API_KEY"]
      zip = "20176"
      stub_request(:get, "https://api.redbox.com/v3/inventory/stores/postalcode/#{zip}?apiKey=#{redbox_api_key}").
         with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => '{"store": {"title": "food lion"}}', :headers => {})
      RedboxApi.get_stores_by_zip(zip).should_not be_nil
    end
  end
  describe "get_inventory_by_store" do
    it "should return json given a store_id" do
      store_id = "31988C35-9BD4-400E-801B-F431AD51B2FC"
      store_inventory_json = File.read("#{Rails.root}/spec/fixtures/store_inventory.json")
      stub_request(:get, "https://api.redbox.com/v3/inventory/stores/31988C35-9BD4-400E-801B-F431AD51B2FC?apiKey=53ad708d7130653ed4685b967f3e7f57").
         with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => store_inventory_json, :headers => {})
      RedboxApi.get_inventory_by_store(store_id).should_not be_nil
    end
  end
end
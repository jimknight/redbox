class RedboxApi < ActiveRecord::Base

  @@redbox_api_key = ENV["REDBOX_API_KEY"]

  def self.get_stores_by_zip(zip)
    url = "https://api.redbox.com/v3/stores/postalcode/#{zip}?apiKey=#{@@redbox_api_key}"
    stores_json = JSON.parse(open(url,"Accept" => "application/json").read)
    return stores_json["StoreBulkList"]["Store"]
  end

  def self.get_inventory_by_store(store_id)
    url = "https://api.redbox.com/v3/inventory/stores/#{store_id}?apiKey=#{@@redbox_api_key}"
    store_inventory_json = JSON.parse(open(url,"Accept" => "application/json").read)
    return store_inventory_json["Inventory"]["StoreInventory"]["ProductInventory"]
  end

  def self.get_product_by_id(product_id)
    url = "https://api.redbox.com/v3/products/#{product_id}?apiKey=#{@@redbox_api_key}"
    return JSON.parse(open(url,"Accept" => "application/json").read)
  end

end

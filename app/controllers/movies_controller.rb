class MoviesController < ApplicationController

  require 'open-uri'
  require 'json'
  def list
    redbox_api_key = ENV["REDBOX_API_KEY"]
    url = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}&retailer=giant&count=2"
    result = JSON.parse(open(url,"Accept" => "application/json").read)
    store_id = result["Inventory"]["StoreInventory"][1]["@storeId"] # second giant store near us
    store_api = "https://api.redbox.com/v3/stores?apiKey=#{redbox_api_key}&storeList=#{store_id}"
    store_json = JSON.parse(open(store_api,"Accept" => "application/json").read)
    product_info = []
    max_loops = 1
    result["Inventory"]["StoreInventory"][1]["ProductInventory"].each do |product|
      if product["@inventoryStatus"] == "InStock" && max_loops > 0
        product_api = "https://api.redbox.com/v3/products?apiKey=#{redbox_api_key}&productIds=#{product["@productId"]}"
        product_json = JSON.parse(open(product_api,"Accept" => "application/json").read)
        product_info << product_json
        max_loops = max_loops - 1
      end
    end
    @products = product_info
  end

end

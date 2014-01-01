require 'open-uri'
require 'json'

namespace :redbox do
  desc "update the inventory"
  task :update_inventory => :environment do
    Product.destroy_all # clear out existing inventory
    redbox_api_key = ENV["REDBOX_API_KEY"]
    rt_api_key     = ENV["ROTTEN_TOMATOES_API_KEY"]
   # url            = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}&retailer=giant&count=2"
    url            = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}"
    result         = JSON.parse(open(url,"Accept" => "application/json").read)
    result["Inventory"]["StoreInventory"].each do |store|
      store_id = store["@storeId"]
      store_api      = "https://api.redbox.com/v3/stores?apiKey=#{redbox_api_key}&storeList=#{store_id}"
    store_json     = JSON.parse(open(store_api,"Accept" => "application/json").read)
    store_name = store_json["StoreBulkList"]["Store"]["Retailer"]
    store_address = store_json["StoreBulkList"]["Store"]["Location"]["Address"]
    product_info   = []
    max_loops      = 5000
    result["Inventory"]["StoreInventory"][1]["ProductInventory"].each do |product|
      if product["@inventoryStatus"] == "InStock" && max_loops > 0
        begin
        product_api = "https://api.redbox.com/v3/products?apiKey=#{redbox_api_key}&productIds=#{product["@productId"]}"
        product_json = JSON.parse(open(product_api,"Accept" => "application/json").read)
        product_info << product_json
        max_loops = max_loops - 1
        movie_title = product_json["Products"]["Movie"]["Title"].gsub(" ","+")
        puts movie_title
        rt_api = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{rt_api_key}&q=#{movie_title}&page_limit=1"
        rt_get = open(rt_api,"Accept" => "application/json").read
        rt_json = JSON.parse(rt_get)
        Product.create!(
          :store_id => store_id,
          :store_name => store_name,
          :store_address => store_address,
          :product_id => product_json["Products"]["Movie"]["@productId"],
          :title => product_json["Products"]["Movie"]["Title"],
          :synopsis => product_json["Products"]["Movie"]["SynopsisShort"],
          :genre => product_json["Products"]["Movie"]["Genres"]["Genre"],
          :rated => product_json["Products"]["Movie"]["MPAARating"],
          :actors => product_json["Products"]["Movie"]["Actors"]["Person"].join(", "),
          :directors => Array(product_json["Products"]["Movie"]["Directors"]["Person"]).join(", "),
          :release_year => product_json["Products"]["Movie"]["ReleaseYear"],
          :critics_rating => rt_json["movies"][0]["ratings"]["critics_rating"],
          :critics_score => rt_json["movies"][0]["ratings"]["critics_score"],
          :audience_rating => rt_json["movies"][0]["ratings"]["audience_rating"],
          :audience_score => rt_json["movies"][0]["ratings"]["audience_score"]
        )
        rescue
          # just skip for now
        end
    end
    # store_id       = result["Inventory"]["StoreInventory"][1]["@storeId"] # second giant store near us

      end
    end
  end
end


# ) $ rails g scaffold product t release_year:string :text :integer audience_rating:text audience_score:integer


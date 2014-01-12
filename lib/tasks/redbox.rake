require 'open-uri'
require 'json'

namespace :redbox do
  desc "update the inventory"
  task :update_inventory => :environment do
    # redbox_api_key = ENV["REDBOX_API_KEY"]
    # rt_api_key     = ENV["ROTTEN_TOMATOES_API_KEY"]

    # pseudo
    # given my zip code - go get all the stores in the area
    zip = "20176" # someday let people pass another zip
    stores_json = RedboxApi.get_stores_by_zip(zip)
    stores_json.each do |store_json|
      store = Store.find_store_by_id_or_create_new_one(store_json["@storeId"], store_json)
    end

    # loop through each store
      # find or create the store in the database
      # clear out the existing store inventory join table
      # loop through each store's inventory and find the ones in stock
        # look for existing product
          # it's not there, add it and do the rotten tomatoes lookup along with pulling image
        # add to this store's inventory
  end
end

   # url            = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}&retailer=giant&count=2"
#     url            = "https://api.redbox.com/v3/inventory/stores/postalcode/20176?apiKey=#{redbox_api_key}"
#     result         = JSON.parse(open(url,"Accept" => "application/json").read)
#     result["Inventory"]["StoreInventory"].each do |store|
#       store_id = store["@storeId"]
#       store_api      = "https://api.redbox.com/v3/stores?apiKey=#{redbox_api_key}&storeList=#{store_id}"
#     store_json     = JSON.parse(open(store_api,"Accept" => "application/json").read)

# store_inventory = JSON.parse(open("https://api.redbox.com/v3/inventory/stores/#{store_id}?apiKey=#{redbox_api_key}","Accept" => "application/json").read)
# binding.pry
#     store_name = store_json["StoreBulkList"]["Store"]["Retailer"]
#     store_address = store_json["StoreBulkList"]["Store"]["Location"]["Address"]
#     product_info   = []
#     max_loops      = 5000
#             store = Store.find_or_create_by_store_id(
#           :store_id => store_id,
#           :store_name => store_name,
#           :store_address => store_address
#           )
#             store.products.delete #clear current inventory for store
#     result["Inventory"]["StoreInventory"][1]["ProductInventory"].each do |product|
#       if product["@inventoryStatus"] == "InStock" && max_loops > 0
#         begin
#           # check to see if product already here. if here, just assign to store
#           product_id = product["@productId"]
#           if Product.find_by_product_id(product_id).nil?
#             product_api = "https://api.redbox.com/v3/products?apiKey=#{redbox_api_key}&productIds=#{product["@productId"]}"
#             product_json = JSON.parse(open(product_api,"Accept" => "application/json").read)
#             product_info << product_json
#             max_loops = max_loops - 1
#             movie_title = product_json["Products"]["Movie"]["Title"].gsub(" ","+")
#             rt_api = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{rt_api_key}&q=#{movie_title}&page_limit=1"
#             rt_get = open(rt_api,"Accept" => "application/json").read
#             rt_json = JSON.parse(rt_get)
#             product = Product.find_or_create_by_product_id(
#               :remote_image_url => product_json["Products"]["Movie"]["BoxArtImages"]["link"][0]["@href"],
#               # :image_url => product_json["Products"]["Movie"]["BoxArtImages"]["link"][0]["@href"],
#               :product_id => product_json["Products"]["Movie"]["@productId"],
#               :title => product_json["Products"]["Movie"]["Title"],
#               :synopsis => product_json["Products"]["Movie"]["SynopsisShort"],
#               :genre => product_json["Products"]["Movie"]["Genres"]["Genre"],
#               :rated => product_json["Products"]["Movie"]["MPAARating"],
#               :actors => product_json["Products"]["Movie"]["Actors"]["Person"].join(", "),
#               :directors => Array(product_json["Products"]["Movie"]["Directors"]["Person"]).join(", "),
#               :release_year => product_json["Products"]["Movie"]["ReleaseYear"],
#               :critics_rating => rt_json["movies"][0]["ratings"]["critics_rating"],
#               :critics_score => rt_json["movies"][0]["ratings"]["critics_score"],
#               :audience_rating => rt_json["movies"][0]["ratings"]["audience_rating"],
#               :audience_score => rt_json["movies"][0]["ratings"]["audience_score"]
#             )
# binding.pry
#           else
#             product = Product.find_by_product_id(product_id)
#           end
#           puts product.title
#         store.products << product
#         rescue
#           # just skip for now
#         end
#     end
#     # store_id       = result["Inventory"]["StoreInventory"][1]["@storeId"] # second giant store near us

#       end
#     end
#   end
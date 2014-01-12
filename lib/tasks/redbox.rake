require 'open-uri'
require 'json'

namespace :redbox do
  desc "update the inventory"
  task :update_inventory => :environment do
    zip = "20176" # someday let people pass another zip
    stores_json = RedboxApi.get_stores_by_zip(zip)
    stores_json.each do |store_json|
      store = Store.find_store_by_id_or_create_new_one(store_json["@storeId"], store_json)
      store.products.delete # clear out the existing store inventory join table
      store_inventory_json = RedboxApi.get_inventory_by_store(store.store_id)
      store_inventory_json.each do |product_json|
        if product_json["@inventoryStatus"] == "InStock"
          product = Product.find_product_by_id_or_create_new_one(product_json["@productId"], product_json)
          if product.present?
            store.products << product
          end
        end
      end
    end
  end
end
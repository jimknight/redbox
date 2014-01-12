class Store < ActiveRecord::Base

  has_and_belongs_to_many :products

  def self.find_store_by_id_or_create_new_one(store_id, store_json)
    store = Store.find_by_store_id(store_id)
    if store.nil?
      store_name = store_json["Retailer"]
      store_address = store_json["Location"]["Address"]
      store = Store.create(:store_id => store_id, :store_name => store_name, :store_address => store_address)
    end
    return store
  end

end

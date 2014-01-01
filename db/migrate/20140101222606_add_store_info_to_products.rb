class AddStoreInfoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :store_name, :string
    add_column :products, :store_address, :string
  end
end

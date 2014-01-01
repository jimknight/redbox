class AddStoreIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :store_id, :string
  end
end

class AddProductIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_id, :string
  end
end

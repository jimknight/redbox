class CreateTable < ActiveRecord::Migration
  def change
    create_table :products_stores do |t|
      t.integer :product_id
      t.integer :store_id
    end
  end
end

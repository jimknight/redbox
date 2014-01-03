class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :store_id
      t.string :store_name
      t.string :store_address

      t.timestamps
    end
  end
end

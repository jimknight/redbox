class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :synopsis
      t.string :genre
      t.string :rated
      t.text :actors
      t.text :directors
      t.string :release_year
      t.text :critics_rating
      t.integer :critics_score
      t.text :audience_rating
      t.integer :audience_score

      t.timestamps
    end
  end
end

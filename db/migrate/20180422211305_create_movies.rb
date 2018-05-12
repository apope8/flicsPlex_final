class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :image_url
      t.string :genre
      t.string :rating

      t.timestamps
    end
  end
end

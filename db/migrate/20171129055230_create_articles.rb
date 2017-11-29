class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :prefecture
      t.string :city
      t.string :station
      t.text :scenes
      t.integer :price

      t.timestamps
    end
  end
end

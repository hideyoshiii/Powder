class CreateSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :spots do |t|
      t.string :title
      t.string :prefecture
      t.string :city
      t.text :scene
      t.string :price
      t.text :description
      t.boolean :introduction
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

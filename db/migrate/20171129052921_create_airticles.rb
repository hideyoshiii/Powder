class CreateAirticles < ActiveRecord::Migration[5.1]
  def change
    create_table :airticles do |t|
      t.string :title
      t.string :prefecture
      t.string :city
      t.string :station
      t.integer :price
      t.text :scenes

      t.timestamps
    end
  end
end

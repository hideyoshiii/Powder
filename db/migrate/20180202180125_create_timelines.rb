class CreateTimelines < ActiveRecord::Migration[5.1]
  def change
    create_table :timelines do |t|
      t.references :course, foreign_key: true
      t.string :city_dinner
      t.integer :price_dinner
      t.string :small_dinner
      t.string :city_lunch
      t.integer :price_lunch
      t.string :small_lunch

      t.timestamps
    end
  end
end

class AddPriceDinnerToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :price_dinner, :integer
    add_column :spots, :price_lunch, :integer
  end
end

class AddPriceSpotToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :price_spot, :integer
  end
end

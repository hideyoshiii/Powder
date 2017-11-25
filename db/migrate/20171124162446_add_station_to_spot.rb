class AddStationToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :station, :string
  end
end

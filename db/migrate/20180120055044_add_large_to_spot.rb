class AddLargeToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :large, :string
    add_column :spots, :small, :string
  end
end

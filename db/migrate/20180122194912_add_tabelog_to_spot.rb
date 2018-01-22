class AddTabelogToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :tabelog, :string
  end
end

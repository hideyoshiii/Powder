class AddTimezoneToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :timezone, :string
  end
end

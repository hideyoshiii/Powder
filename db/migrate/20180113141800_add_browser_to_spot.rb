class AddBrowserToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :browser, :string
    add_column :spots, :phone, :string
  end
end

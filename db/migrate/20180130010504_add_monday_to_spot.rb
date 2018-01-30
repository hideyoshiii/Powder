class AddMondayToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :monday, :string
    add_column :spots, :tuesday, :string
    add_column :spots, :wednesday, :string
    add_column :spots, :thursday, :string
    add_column :spots, :friday, :string
    add_column :spots, :saturday, :string
    add_column :spots, :sunday, :string
    add_column :spots, :holiday, :string
    add_column :spots, :access, :string
    add_column :spots, :service, :string
    add_column :spots, :charge, :string
    add_column :spots, :smoking, :string
  end
end

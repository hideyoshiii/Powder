class AddHeadingToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :heading, :text
  end
end

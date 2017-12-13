class AddLikesCountToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :likes_count, :integer
  end
end

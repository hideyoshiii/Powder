class AddArticleIdToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :Article_id, :integer
    add_column :spots, :Retty, :string
  end
end

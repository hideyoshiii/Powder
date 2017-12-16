class RenameRettyColumnToSpots < ActiveRecord::Migration[5.1]
  def change
  	rename_column :spots, :Article_id, :article_id
  	rename_column :spots, :Retty, :Retty
  end
end

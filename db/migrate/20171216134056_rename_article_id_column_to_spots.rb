class RenameArticleIdColumnToSpots < ActiveRecord::Migration[5.1]
  def change
  	rename_column :spots, :Retty, :retty
  end
end

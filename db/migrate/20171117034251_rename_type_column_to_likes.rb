class RenameTypeColumnToLikes < ActiveRecord::Migration[5.1]
  def change
  	rename_column :likes, :type, :kind
  end
end

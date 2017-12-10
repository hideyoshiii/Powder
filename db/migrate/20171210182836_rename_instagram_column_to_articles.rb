class RenameInstagramColumnToArticles < ActiveRecord::Migration[5.1]
  def change
  	rename_column :articles, :instagram, :content
  end
end

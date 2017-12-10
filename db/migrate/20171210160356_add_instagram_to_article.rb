class AddInstagramToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :instagram, :text
  end
end

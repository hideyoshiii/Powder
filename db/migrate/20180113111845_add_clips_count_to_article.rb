class AddClipsCountToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :clips_count, :integer
  end
end

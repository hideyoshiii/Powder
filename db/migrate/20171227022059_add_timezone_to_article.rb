class AddTimezoneToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :Timezone, :integer
    add_column :articles, :Number, :integer
  end
end

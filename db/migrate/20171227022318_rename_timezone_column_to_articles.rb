class RenameTimezoneColumnToArticles < ActiveRecord::Migration[5.1]
  def change
  	rename_column :articles, :Timezone, :timezone
  	rename_column :articles, :Number, :number
  end
end

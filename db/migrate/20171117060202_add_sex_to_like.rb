class AddSexToLike < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :sex, :string
  end
end

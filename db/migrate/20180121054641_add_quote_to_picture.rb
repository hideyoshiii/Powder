class AddQuoteToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :quote, :string
    add_column :pictures, :url, :string
  end
end

class AddNumberToPoint < ActiveRecord::Migration[5.1]
  def change
    add_column :points, :number, :integer
  end
end

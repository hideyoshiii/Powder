class AddTimezoneToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :timezone, :string
  end
end

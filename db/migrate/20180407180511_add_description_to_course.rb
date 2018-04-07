class AddDescriptionToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :text
    add_column :courses, :time_start, :string
    add_column :courses, :time_end, :string
    add_column :courses, :type, :string
  end
end

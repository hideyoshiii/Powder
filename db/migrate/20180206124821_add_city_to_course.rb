class AddCityToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :city, :string
  end
end

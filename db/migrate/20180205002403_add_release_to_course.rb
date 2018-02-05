class AddReleaseToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :release, :boolean, default: false, null: false
    add_column :courses, :price_used, :integer
    add_column :courses, :good_point, :text
    add_column :courses, :bad_point, :text
  end
end

class ChangeDatatypeReleaseOfCourses < ActiveRecord::Migration[5.1]
  def change
  	add_column :courses, :went, :string
  end
end

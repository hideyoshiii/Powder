class AddCourseRefToPictures < ActiveRecord::Migration[5.1]
  def change
    add_reference :pictures, :course, foreign_key: true
  end
end

class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :user, foreign_key: true
      t.integer :spot1_id
      t.integer :spot2_id
      t.integer :spot3_id
      t.integer :spot4_id

      t.timestamps
    end
  end
end

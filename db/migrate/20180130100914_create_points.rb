class CreatePoints < ActiveRecord::Migration[5.1]
  def change
    create_table :points do |t|
      t.references :spot, foreign_key: true
      t.references :course, foreign_key: true
      t.string :memo

      t.timestamps
    end
  end
end

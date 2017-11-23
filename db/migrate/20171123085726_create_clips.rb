class CreateClips < ActiveRecord::Migration[5.1]
  def change
    create_table :clips do |t|
      t.string :sex
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end

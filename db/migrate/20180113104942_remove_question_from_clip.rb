class RemoveQuestionFromClip < ActiveRecord::Migration[5.1]
  def change
    remove_reference :clips, :question, foreign_key: true
  end
end

class RemoveSpotFromAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_reference :answers, :spot, foreign_key: true
  end
end

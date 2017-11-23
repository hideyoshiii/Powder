class RemoveSpotIdToAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :spot, :references
  end
end

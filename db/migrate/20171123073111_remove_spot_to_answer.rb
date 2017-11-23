class RemoveSpotToAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :spot, :string
  end
end

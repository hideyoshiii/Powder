class RenameSceneColumnToSpots < ActiveRecord::Migration[5.1]
  def change
  	rename_column :spots, :scene, :scenes
  end
end

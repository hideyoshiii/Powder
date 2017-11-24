class ChangeDatatypeIntroductionOfSpots < ActiveRecord::Migration[5.1]
  def change
  	change_column :spots, :introduction, :string
  end
end

class AddAttachmentPhotoToSpots < ActiveRecord::Migration[5.1]
  def self.up
    change_table :spots do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :spots, :photo
  end
end

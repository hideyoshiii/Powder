class AddAttachmentPhotoToQuestions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :questions do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :questions, :photo
  end
end

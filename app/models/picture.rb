class Picture < ApplicationRecord
  belongs_to :spot
  belongs_to :user
  

  has_attached_file :image, default_url: "missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end

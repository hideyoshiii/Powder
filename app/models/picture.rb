class Picture < ApplicationRecord
  belongs_to :spot

  has_attached_file :image, styles: { medium: "740x500", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end

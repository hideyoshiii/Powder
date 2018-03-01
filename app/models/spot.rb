class Spot < ApplicationRecord

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  serialize :scenes
  serialize :large
  serialize :small
  serialize :timezone

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :points, dependent: :destroy
  

  
  has_attached_file :photo, default_url: "missing.png"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  
  acts_as_taggable_on :labels # post.label_list が追加される
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス


  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end




  
end

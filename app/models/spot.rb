class Spot < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :prefecture, presence: true

  serialize :scenes
  serialize :large
  serialize :small

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  has_many :likes, dependent: :destroy
  has_many :pictures, dependent: :destroy
  

  
  has_attached_file :photo, styles: { medium: "400x400", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  
  acts_as_taggable_on :labels # post.label_list が追加される
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス


  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end




  
end

class Spot < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :prefecture, presence: true

  serialize :scenes

  has_many :likes, dependent: :destroy
  

  # photoをattachファイルとする。stylesで画像サイズを定義できる
  has_attached_file :photo, styles: { medium: "740x500", thumb: "100x100>" }, default_url: "missing.png"

  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  acts_as_taggable_on :labels # post.label_list が追加される
  acts_as_taggable            # acts_as_taggable_on :tags のエイリアス


  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end




  
end

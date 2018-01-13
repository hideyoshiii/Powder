class Article < ApplicationRecord
	
	validates :title, presence: true
  	validates :prefecture, presence: true

  	serialize :scenes

  	has_many :snaps, dependent: :destroy

  	# photoをattachファイルとする。stylesで画像サイズを定義できる
	  has_attached_file :photo, styles: { medium: "400x400", thumb: "100x100>" }, default_url: "missing.png"

	# ファイルの拡張子を指定（これがないとエラーが発生する）
	validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	acts_as_taggable_on :movies # post.label_list が追加される


	def clip_user(user_id)
	   clips.find_by(user_id: user_id)
	  end

  	
end

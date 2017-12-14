class Article < ApplicationRecord
	
	validates :title, presence: true
  	validates :prefecture, presence: true

  	serialize :scenes

  	# photoをattachファイルとする。stylesで画像サイズを定義できる
	  has_attached_file :photo, styles: { medium: "740x500", thumb: "100x100>" }, default_url: "missing.png"

	# ファイルの拡張子を指定（これがないとエラーが発生する）
	validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	acts_as_taggable_on :movies # post.label_list が追加される
  	
end

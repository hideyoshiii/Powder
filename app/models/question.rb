class Question < ApplicationRecord
  belongs_to :user

  validates :category, presence: true
  validates :content, presence: true
  validates :sex, presence: true

  # photoをattachファイルとする。stylesで画像サイズを定義できる
  has_attached_file :photo, styles: { large: "740x500", medium: "650x400", thumb: "100x100>" }

  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end

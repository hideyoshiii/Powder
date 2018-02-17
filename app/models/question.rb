class Question < ApplicationRecord
  belongs_to :user

  validates :category, presence: true
  validates :content, presence: true
  validates :sex, presence: true

  has_many :answers, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :comments, dependent: :destroy

  # photoをattachファイルとする。stylesで画像サイズを定義できる
  has_attached_file :photo, default_url: "missing.png"

  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end

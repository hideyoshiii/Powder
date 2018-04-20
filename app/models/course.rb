class Course < ApplicationRecord
  belongs_to :user
  has_many :points, dependent: :destroy
  has_many :timelines, dependent: :destroy
  has_many :copies, dependent: :destroy
  has_many :loves, dependent: :destroy

  def love_user(user_id)
   loves.find_by(user_id: user_id)
  end
end

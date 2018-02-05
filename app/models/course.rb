class Course < ApplicationRecord
  belongs_to :user
  has_many :points, dependent: :destroy
  has_many :timelines, dependent: :destroy
  has_many :copies, dependent: :destroy
  has_many :pictures, dependent: :destroy
end

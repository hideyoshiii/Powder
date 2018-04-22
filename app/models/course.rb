class Course < ApplicationRecord
  belongs_to :user
  has_many :points, dependent: :destroy
  has_many :timelines, dependent: :destroy
  has_many :copies, dependent: :destroy
  has_many :love, dependent: :destroy

  acts_as_taggable_on :course # course.course_list が追加される

end

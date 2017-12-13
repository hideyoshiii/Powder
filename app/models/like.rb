class Like < ApplicationRecord
  belongs_to :user
  belongs_to :spot, counter_cache: :likes_count
end

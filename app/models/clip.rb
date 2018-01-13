class Clip < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: :clips_count
end

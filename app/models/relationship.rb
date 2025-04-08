class Relationship < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end

class Relationship < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # バリデーション追加（フォロー・フォロワーの関係一意に保持）　2025/04/08
  validates_uniqueness_of :follower_id, scope: :followed_id
end

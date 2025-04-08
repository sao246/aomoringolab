class Favorite < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  belongs_to :post

  # バリデーション追加（同じユーザーは1投稿1いいねのみ）2025/04/08
  validates_uniqueness_of :user_id, scope: :post_id
  validates :post_id, presence: true
  validates :user_id, presence: true
end

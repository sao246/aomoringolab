class Comment < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  belongs_to :post

  # バリデーション追加（入力必須項目）2025/04/08
  validates :body, presence: true
  validates :body, length: { maximum: 500 }

  validates :post_id, presence: true
  validates :user_id, presence: true
end

class PostTag < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :tag
  belongs_to :post

  # バリデーション追加 2025/04/08
  validates :post_id, presence: true
  validates :post_id, uniqueness: { scope: :tag_id }
  validates :tag_id, presence: true
end

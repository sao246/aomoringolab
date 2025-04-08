class Tag < ApplicationRecord
  # アソシエーション追加 2025/04/08
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags
end

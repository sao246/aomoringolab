class PostTag < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :tag
  belongs_to :post
end

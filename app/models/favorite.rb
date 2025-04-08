class Favorite < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  belongs_to :post
end

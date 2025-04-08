class Tag < ApplicationRecord
  # アソシエーション追加 2025/04/08
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  # バリデーション追加（入力必須、同名タグの登録防止）2025/04/08
  validates :name, presence: true
  validates :name, uniqueness: true
end

class Post < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # バリデーション追加（入力必須項目）2025/04/08
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 1000 }

  validates :user_id, presence: true
  validates :post_id, presence: true
end

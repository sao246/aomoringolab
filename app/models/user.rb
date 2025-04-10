class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # アソシエーション追加 2025/04/08
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # プロフィール写真用の設定 2025/04/09
  has_one_attached :profile_image

  # ユーザーがフォローしている他のユーザーとの関連付け、データ取得設定
  # 後ほど追加

  # 自分をフォローしているユーザの関連付け、データ取得設定
  # 後ほど追加
  
   # バリデーション追加 2025/04/08
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # バリデーション追加 2025/04/08
  validates :introduction, length: { maximum: 200 }
end

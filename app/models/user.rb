class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # アソシエーション追加 2025/04/08
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # ユーザーがフォローしている他のユーザーとの関連付け、データ取得設定
  has_many :relationships, dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  # 自分をフォローしているユーザの関連付け、データ取得設定
  has_many :inverse_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :inverse_relationships, source: :follower
end

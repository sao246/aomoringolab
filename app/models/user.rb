class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 管理者が使う会員の退会ステータス（Enum利用） 2025/04/16
  enum status: { active: 0, deactivated: 1 }
  def active_for_authentication?
    super && active?  # activeステータスならログインOKとする
  end

  def inactive_message
    deactivated? ? :account_deactivated : super  # 退会済みならメッセージを変更する。
  end

  # アソシエーション追加 2025/04/08
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # プロフィール写真用の設定 2025/04/09
  has_one_attached :profile_image

  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
   # バリデーション追加 2025/04/08
  validates :name, length: { minimum: 3, maximum: 15 }, uniqueness: true
  # バリデーション追加 2025/04/08
  validate :introduction_length_within_limit

  # ゲストログイン用の情報設定 2025/04/11
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end

  def guest_user?
    self.email == 'guest@example.com'
  end
  
  # 検索ボックス追加用のメソッド 2025/04/14
  # 部分一致検索だけ、名前かemail検索ができるように変更。2025/04/19
  def self.search_for(content, method)
    if method == 'partial'
      User.where('name LIKE :q OR email LIKE :q', q: "%#{content}%")
    end
  end
  
  # ユーザーにプロフィール画像が添付されているかを検索するメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォロー処理メソッド
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  # フォロー解除処理メソッド
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  # 対象ユーザがフォローしているかを確認するメソッド
  def following?(user)
    followings.include?(user)
  end

  # フォロー中ユーザーの投稿を取得
  def following_posts
    followed_users.joins(:posts).select('posts.*')
  end
  
  private
  def introduction_length_within_limit
    if introduction && introduction.mb_chars.length > 200
      errors.add(:introduction, "は200文字以内で入力してください（現在#{introduction.mb_chars.length}文字）")
    end
  end
end

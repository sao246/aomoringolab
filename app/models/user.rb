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

  # ユーザーがフォローしている他のユーザーとの関連付け、データ取得設定
  # 後ほど追加

  # 自分をフォローしているユーザの関連付け、データ取得設定
  # 後ほど追加
  
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

  # 検索ボックス追加用のメソッド 2025/04/14
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  private
  def introduction_length_within_limit
    if introduction && introduction.mb_chars.length > 200
      errors.add(:introduction, "は200文字以内で入力してください（現在#{introduction.mb_chars.length}文字）")
    end
  end
end

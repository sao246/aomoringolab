class Post < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  # バリデーション追加（入力必須項目）2025/04/08
  validates :title, presence: true
  validates :body, presence: true
  validate :title_length_within_limit
  validate :body_length_within_limit
  validates :user_id, presence: true

  # 検索ボックス追加用のメソッド 2025/04/14
  # 部分一致検索だけ、投稿本文かタイトルのキーワード検索ができるように変更。2025/04/19
  def self.search_for(content, method)
    if method == 'partial'
      Post.where('title LIKE :q OR body LIKE :q', q: "%#{content}%")
    end
  end

  # いいね（りんご）ボタン用のメソッド 2025/04/20
  def favorited_by?(user)
    # 未ログイン時にTop画面呼び出しなどで、current_userが呼ばれてエラーになるのを防ぐ。
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end  

  private
  def title_length_within_limit
    if title.present? && title.mb_chars.length > 20
      errors.add(:title, "は20文字以内で入力してください（現在#{title.mb_chars.length}文字）")
    end
  end
  
  def body_length_within_limit
    if body.present? && body.mb_chars.length > 500
      errors.add(:body, "は500文字以内で入力してください（現在#{body.mb_chars.length}文字）")
    end
  end
end

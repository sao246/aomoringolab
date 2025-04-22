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
      # joinsでPostテーブルと、Tagテーブルを結びつける。(INNER JOIN)
      # q:〜で部分一致、distinctはDISTINCT（重複排除するSQL）。
      Post.joins(:tags).where('posts.title LIKE :q OR posts.body LIKE :q OR tags.name LIKE :q', q: "%#{content}%").distinct
    end
  end

  # いいね（りんご）ボタン用のメソッド 2025/04/20
  def favorited_by?(user)
    # 未ログイン時にTop画面呼び出しなどで、current_userが呼ばれてエラーになるのを防ぐ。
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end  
  
  # タグ登録処理用
  attr_accessor :tag_names
  validate :validate_tag_names

  # 登録タグのバリデーションチェック
  def validate_tag_names
    return if tag_names.blank? # タグが空文字なら戻る。
    tag_list = tag_names.split(',').map(&:strip).reject(&:blank?).uniq
    tag_list.each do |name|
      if name.match?(/[<>\/]/) # 不正文字の入力防止
        errors.add(:tag_names, "に使用できない文字（<, >, /）が含まれています")
      elsif name.length > 20 # タグは20文字以内で登録させる
        errors.add(:tag_names, "は20文字以内で入力してください（\現在#{name.length}文字）")
      end
    end
  end

  # タグの登録処理
  def save_tags
    return if tag_names.blank?
  
    tag_list = tag_names.split(',').map(&:strip).reject(&:blank?).uniq
    tags = tag_list.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = tags
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

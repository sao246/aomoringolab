class Comment < ApplicationRecord
  # アソシエーション追加 2025/04/08
  belongs_to :user
  belongs_to :post

  # バリデーション追加（入力必須項目）2025/04/08
  # バリデーション上限文字数の設定変更 2025/04/17
  validates :body, presence: true
  validate :body_length_within_limit

  validates :post_id, :user_id, presence: true
  private
  def body_length_within_limit
    return if body.blank?
    length = body.mb_chars.length
    if length > 500
      errors.add(:body, "は500文字以内で入力してください（現在#{length}文字）")
    end
  end
end

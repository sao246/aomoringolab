class Admin::TrendsController < ApplicationController
  #コントローラ追加 2025/04/18
  def index
    # いいねされている数が多いユーザー順に並べる
    @user_likes = User.joins(:favorites)
                      .where(favorites: { created_at: Time.current.beginning_of_month..Time.current.end_of_month })
                      .group(:id, :name)
                      .select('users.id, users.name, COUNT(favorites.id) as favorites_count')
                      .order('favorites_count DESC')

    # タグの累積使用回数を集計して、使用回数の多い順に並べて、上位20件を取得
    @tag_ranking = Tag
      .joins(:post_tags)
      .group('tags.id', 'tags.name')
      .order('COUNT(post_tags.id) DESC')
      .limit(20)
      .pluck('tags.name, COUNT(post_tags.id) as tag_count')
  end
end

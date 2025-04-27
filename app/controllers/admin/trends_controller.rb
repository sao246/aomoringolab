class Admin::TrendsController < ApplicationController
  #コントローラ追加 2025/04/18
  def index
    @post_likes = Post
    .left_joins(:favorites)
    .where(posts: { created_at: 6.months.ago..Time.current }) # Postのcreated_atで範囲指定
    .group(:id)
    .select('posts.id, posts.title, COUNT(favorites.id) as favorites_count')
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

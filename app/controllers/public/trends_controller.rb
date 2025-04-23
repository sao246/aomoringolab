class Public::TrendsController < ApplicationController
  #コントローラ追加 2025/04/07
  def show
    @top_posts = Post.left_joins(:favorites)
    .group(:id)
    .order('COUNT(favorites.id) DESC')
    .limit(5)
  end
end

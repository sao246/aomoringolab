class Public::HomesController < ApplicationController
  # コントローラ追加 2025/04/07
  def top
    @posts = Post.order(created_at: :desc).limit(5)
  end

  def about
  end

  def feed
  end
end

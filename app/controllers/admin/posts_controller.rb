class Admin::PostsController < ApplicationController
  #コントローラ追加 2025/04/07
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

  end
end

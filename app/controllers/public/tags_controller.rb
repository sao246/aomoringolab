class Public::TagsController < ApplicationController
  #コントローラ追加 2025/04/07
  def index
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user).order(created_at: :desc)
  end
end

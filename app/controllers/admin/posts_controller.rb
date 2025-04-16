class Admin::PostsController < ApplicationController
  # パラメータ設定の処理追加
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # ログインしていない人への処理制御
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    #set_post呼び出しするので、個別のPost.findは実施しない。
    @comment = Comment.new
  end

  def destroy
    #set_post呼び出しするので、個別のPost.findは実施しない。
    @post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end

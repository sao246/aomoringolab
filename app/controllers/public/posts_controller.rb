class Public::PostsController < ApplicationController
  #コントローラ追加 2025/04/07
  # パラメータ設定の処理追加
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # ログインしていない人への処理制御
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    #set_postメソッドを用意しているので個別の変数設定は不要。
    if user_signed_in?
    else
      flash[:alert] = "投稿詳細をご覧になるにはログインが必要です。下記ボタンよりゲストユーザーログインまたは会員ログインしてから詳細をご覧ください。"
      redirect_to root_path
    end
  end

  def create
    puts "送信された本文の文字数: #{params[:post][:body].length}"
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿が完了しました'
    else
      render :new
    end
  end

  def edit
      #set_postメソッドを用意しているので個別の変数設定は不要。
  end

  def update
    #set_postメソッドを用意しているので個別の変数設定は不要。
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    #set_postメソッドを用意しているので個別の変数設定は不要。
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end

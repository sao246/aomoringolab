class Public::PostsController < ApplicationController
  #コントローラ追加 2025/04/07
  # パラメータ設定の処理追加
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # ログインしていない人への処理制御
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # ログインユーザーではない人の編集ができないように制御 2025/04/13
  before_action :is_matching_post_login_user, only: [:edit, :update, :destroy, :unsubscribe]
  def new
    if current_user.email == "guest@example.com"
      redirect_to root_path, alert: 'ゲストユーザーは新規投稿ができません。投稿を行う場合はまず新規会員登録を行なってください。'
    else
      @post = Post.new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    #set_postメソッドを用意しているので個別の変数設定は不要。
    if user_signed_in?
    else
      flash[:alert] = "投稿詳細をご覧になるにはログインが必要です。下記ボタンよりゲストユーザーログインまたは会員ログインしてから詳細をご覧ください。"
      redirect_to root_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.tag_names = params[:tag_names]
  
    if @post.valid?
      @post.save
      @post.save_tags
      redirect_to post_path(@post), notice: '投稿が完了しました'
    else
      render :new
    end
  end

  def edit
    #set_postメソッドを用意しているので個別の変数設定は不要。
  end

  def update
    @post.assign_attributes(post_params)
    @post.tag_names = params[:tag_names]
    
    if @post.valid?
      @post.save
      @post.save_tags
      redirect_to post_path(@post), notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    #set_postメソッドを用意しているので個別の変数設定は不要。
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  # tagはPostモデルの属性ではないので、post_paramsには含めない
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

   # ログインユーザーではない人の編集ができないように制御 2025/04/13
  def is_matching_post_login_user
    unless @post.user == current_user
    redirect_to posts_path, alert: "他のユーザーの投稿は編集できません。"
    end
  end
end

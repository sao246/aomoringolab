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
  
    if @post.invalid? # 通常のバリデーションチェック
      render :new and return
    end

    # AI実装に向けて記載修正 2025/05/05
    # begin~rescue~endで想定外のエラーハンドリングをする。
    # 単にSaveだけでなくsave_tagsという独自メソッドを入れたためエラーのケアをする
    begin
      @post.save!
      @post.save_tags
      redirect_to post_path(@post), notice: '投稿が完了しました'
    rescue => e # save!で発生したエラーを捕まえる（想定外のエラーになった場合に500サーバーエラー画面にならないようにする）
      flash.now[:alert] = "投稿処理中にエラーが発生しました: #{e.message}"
      render :new
    end
  end

  # AIタグ付け自動化メソッド 2025/05/05
  def generate_tags
    # /posts/new.htmlのフォームから送られてきたタイトルと本文を設定する。
    title = params[:title]
    body = params[:body]
  
    # 一時的なPostインスタンス変数を作って、postモデルのAIタグ生成メソッドを呼び出す
    post = Post.new(title: title, body: body)
    begin
      post.generate_tags_from_text # postモデルの処理用メソッド
      tags = post.tag_names.present? ? post.tag_names.split(',') : []
      render json: { tags: post.tag_names }, status: :ok
    rescue => e # 想定外エラーのハンドリング
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  
  def edit
    #set_postメソッドを用意しているので個別の変数設定は不要。
    if current_user.guest_user?
      redirect_to post_path(@post), notice: "ゲストユーザーでの投稿編集はできません。閲覧のみ可能です。"
    else
    end
  end

  def update
    @post.assign_attributes(post_params)
    @post.tag_names = params[:tag_names]
    @post.generate_tags_from_text

    if @post.valid?
      ActiveRecord::Base.transaction do
        @post.save!
        @post.save_tags
      end
        redirect_to post_path(@post), notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    #set_postメソッドを用意しているので個別の変数設定は不要。
    if current_user.guest_user?
      redirect_to post_path(@post), notice: "ゲストユーザーでの投稿編集はできません。閲覧のみ可能です。"
    else
      @post.destroy
      redirect_to posts_path, notice: '投稿を削除しました。'
    end
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

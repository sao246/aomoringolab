class Public::HomesController < ApplicationController
  # コントローラ追加 2025/04/07
  def top
    @posts = Post.order(created_at: :desc).limit(5)
  end

  def about
  end

  def feed
    # ログインユーザーがフォローしているユーザーの新着投稿と、ユーザー自身がいいねをした他ユーザーの投稿を月ごとに表示させるフィードを作る
    # 現在のログインユーザーを取得
    @user = current_user

    # 月と年の選択があれば、その年月でフィルタリング(デフォルトは全データ表示)
    selected_year = params[:year].to_i if params[:year].present?
    selected_month = params[:month].to_i if params[:month].present?

    # いいねした投稿の取得
    # ログインしているユーザーがいいね(FavoriteテーブルのID)を登録しているデータを抽出する
    @liked_posts = Post.joins(:favorites)
                       .where(favorites: { user_id: @user.id })
                       .order(created_at: :desc)
    # 重複排除
    @liked_posts = @liked_posts.distinct

    # フォローしているユーザーの投稿を取得（新着順5件以内、3ヶ月以内の期間 ※PFのため、広めに期間を取る。）
    @following_posts = Post.where(user_id: @user.followings.pluck(:id))
                            .where('created_at >= ?', 3.month.ago)
                            .order(created_at: :desc)

    @following_posts = @following_posts.take(5)
  end
end

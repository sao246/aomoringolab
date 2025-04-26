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
    
    # 年月でフィルタリングする。先に選んだ年月で絞る。
    if selected_year.present? && selected_month.present?
      @liked_posts = @liked_posts.where(created_at: Time.new(selected_year, selected_month)..Time.new(selected_year, selected_month).end_of_month)
    end

    @liked_posts = @liked_posts.distinct

    # フォローしているユーザーの投稿を取得（新着順5件以内）
    @following_posts = Post.where(user_id: @user.followings.pluck(:id))
                            .where('created_at >= ?', 2.month.ago)  # ここはポートフォリオのデータ上2ヶ月で広めに取っておく。
                            .order(created_at: :desc)
                            .limit(5)
  end
end

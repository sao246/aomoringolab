class Public::TrendsController < ApplicationController
  def show
    @user = current_user

    # ログインユーザーがいいねした投稿添付のタグ上位3つを取得
    liked_top_tags = Tag.joins(posts: :favorites)
                        .where(favorites: { user_id: @user.id })
                        .group('tags.id')
                        .order('COUNT(tags.id) DESC')

    # Ruby側で上位3つを取得
    liked_top_tags = liked_top_tags.take(3)

    # 上位タグが含まれる他の人の投稿を取得（自分の投稿は除外）
    @recommended_posts = Post.joins(:tags)
                              .where(tags: { id: liked_top_tags })
                              .where.not(user_id: @user.id)
                              .distinct

    # Ruby側で上位3つを取得
    @recommended_posts = @recommended_posts.take(3)

    # あなたの人気投稿用（いいねが多い順に並べる）
    @popular_posts = current_user.posts
                                  .left_joins(:favorites)
                                  .group('posts.id')
                                  .order('COUNT(favorites.id) DESC')

    # Ruby側で上位3つを取得
    @popular_posts = @popular_posts.take(3)

    # 自分がいいねしている投稿でタグ使用回数の多い順に並べる
    @liked_tags = Tag.joins(posts: :favorites)
                     .where(favorites: { user_id: @user.id })
                     .group('tags.id')
                     .order('COUNT(tags.id) DESC')

    # Ruby側で上位3つを取得
    @liked_tags = @liked_tags.take(3)
    
    # アオモリンゴラボ全体のタグ付けランキング用円グラフ（上位10件）
    overall_top_tags = Tag.joins(:posts)
                          .group('tags.id')
                          .order('COUNT(posts.id) DESC')
                          .pluck('tags.name', 'COUNT(posts.id) as count')

    # Ruby側で上位10件を取得
    overall_top_tags = overall_top_tags.first(10)

    # グラフ用データを整形
    @chart_data = {
      labels: overall_top_tags.map(&:first),
      datasets: [{
        label: "タグ別投稿数(上位10件)",
        data: overall_top_tags.map(&:second),
        backgroundColor: overall_top_tags.map { |tag| generate_fixed_color(tag.first) }
      }]
    }
  end

  private

  # 固定の色を生成するメソッド
  def generate_fixed_color(tag_name)
    # 暖色系の色（赤系、オレンジ系、黄色系）
    colors = [
      "hsl(0, 70%, 70%)",   # 赤
      "hsl(30, 70%, 70%)",  # オレンジ
      "hsl(60, 70%, 70%)",  # 黄色
      "hsl(15, 70%, 70%)",  # 濃いオレンジ
      "hsl(45, 70%, 70%)"   # 明るい黄色
    ]
    
    # タグ名に基づいて色を選定（ハッシュ値を使って）
    hash = tag_name.hash
    colors[hash % colors.length]
  end
end

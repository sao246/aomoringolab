class Public::TrendsController < ApplicationController
  def show
    # ログインユーザーがいいねした投稿添付のタグ上位を取得
    @user = current_user
    top_tags = Tag.joins(posts: :favorites)
                  .where(favorites: { user_id: current_user.id })
                  .group('tags.id')
                  .order('COUNT(tags.id) DESC')
                  .limit(3)

    # 上位タグが含まれる他の人の投稿を取得
    @recommended_posts = Post.joins(:tags)
                             .where(tags: { id: top_tags })
                             .where.not(user_id: @user.id)
                             .distinct
                             .limit(3)

    # あなたの人気投稿用（いいねが多い順に並べる）
    @popular_posts = current_user.posts
                                 .left_joins(:favorites)
                                 .group('posts.id')
                                 .order('COUNT(favorites.id) DESC')
                                 .limit(3)

    # 自分がいいねしている投稿でタグ使用回数の多い順に並べる
    @liked_tags = Tag.joins(posts: :favorites)
                     .where(favorites: { user_id: current_user.id })
                     .group('tags.id')
                     .order('COUNT(tags.id) DESC')
                     .limit(3)

    # アオモリンゴラボ全体のタグ付けランキング用円グラフ
    # 直近12ヶ月分の年月（表示用とvalue用）を作成
    @months = (0..11).map do |i|
      date = Date.today.prev_month(i)
      year_month = "#{date.year}年#{date.month}月"
      [year_month, date.year * 100 + date.month]  # 年と月を組み合わせて数値に
    end

    # 選択された年月。なければ今月（例：202504）
    @selected_month = (params[:month] || Date.today.year * 100 + Date.today.month).to_i

    # 年と月に分解
    selected_year = @selected_month.to_s[0..3]
    selected_month = @selected_month.to_s[4..5].rjust(2, '0')  # ゼロ埋めして2桁にする

    # 月ごとのタグランキングを取得（Ruby側で日付を処理）
    start_date = Date.new(selected_year.to_i, selected_month.to_i, 1)
    end_date = start_date.end_of_month

    top_tags = Tag.joins(:posts)
                  .select("tags.name, posts.created_at")
                  .where(posts: { created_at: start_date..end_date })
                  .group("tags.id")
                  .order("COUNT(posts.id) DESC")
                  .limit(10)
                  .pluck("tags.name, COUNT(posts.id) as count")

    # グラフ用データを整形
    @chart_data = {
      labels: top_tags.map(&:first),
      datasets: [{
        label: "#{selected_year}年#{selected_month.to_i}月のタグ別投稿数(上位10件のみ)",
        data: top_tags.map(&:second),
        backgroundColor: top_tags.map { |tag| generate_fixed_color(tag.first) }
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
    return colors[hash % colors.length]
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# 農家ユーザー10件の作成
10.times do |i|
  User.create!(
    email: "farmer#{i + 1}@email",
    password: "farmer#{i + 1}password",  # ユーザーごとに異なるパスワード
    password_confirmation: "farmer#{i + 1}password",
    name: "農家#{i + 1}",
    introduction: "テストユーザーです。",
    status: 0  # active
  )
end

# りんご愛好家ユーザー10件の作成
10.times do |i|
  User.create!(
    email: "applelover#{i + 1}@email",
    password: "applelover#{i + 1}password",  # ユーザーごとに異なるパスワード
    password_confirmation: "applelover#{i + 1}password",
    name: "りんご愛好家#{i + 1}",
    introduction: "テストユーザーです。",
    status: 0  # active
  )
end

# 農家ユーザーによる投稿（1人1件ずつ）
def random_past_date
  rand(30..180).days.ago
end
User.where("name LIKE ?", "農家%").each_with_index do |user, i|
  titles = [
    "摘果作業が始まりました",
    "霜対策に追われる日々",
    "受粉のタイミングが勝負",
    "剪定で未来の実りを作る",
    "袋かけ作業、黙々と",
    "収穫直前の見極めが大事",
    "今年は害虫が多い",
    "りんごの色付きチェック",
    "雪下ろし作業で腰が痛い",
    "直売所を設置しました！！"
  ]

  dates = [
    Time.new(2024, 5, 15),
    Time.new(2024, 4, 25),
    Time.new(2024, 3, 10),
    Time.new(2024, 2, 15),
    Time.new(2024, 6, 20),
    Time.new(2024, 9, 10),
    Time.new(2024, 8, 1),
    Time.new(2024, 9, 18),
    Time.new(2024, 2, 10),
    Time.new(2024, 9, 15)
  ]

  bodies = [
    "今年もいよいよ摘果作業の季節。無駄な実を落とすことで、残るりんごがしっかり育ってくれます。毎年地味だけど大切な作業です。",
    "朝晩の冷え込みが厳しく、霜で花芽がやられないか心配です。防霜ファンと囲いでなんとかしのいでいます。",
    "りんごの受粉はほんの数日が勝負。天候を見ながらミツバチの働きに期待。人工授粉も少しだけ補助的に行いました。",
    "冬の剪定は春と秋の実りを左右します。樹形を整えながら、来年も良いりんごができるよう考えながら切ってます。",
    "袋かけは手間がかかりますが、見た目がきれいなりんごを作るには欠かせません。今年も地道に一つずつかけてます。",
    "あと数日で収穫。実の色、硬さ、糖度を確認して収穫のタイミングを見極めています。毎年ドキドキする時期です。",
    "今年はカメムシが多くて、葉っぱに被害が出ています。防除のタイミングが重要で、例年以上に気を使ってます。",
    "りんごの色付きが進んできました。太陽の当たり具合や日焼けも考慮しながら、葉の取り方に工夫しています。",
    "雪が降った日は大変。ハウスの上や木の枝から雪を落とさないと潰れてしまいます。冬は体力勝負です。",
    "今年も収穫の季節がやってきました。山の上農園では直売所を設置しました。また、来週からは道の駅つがるでもジョナゴールドとふじの直売が始まりますので、お近くにお越しの際はぜひお立ち寄りください。"
  ]

  date = random_past_date

  Post.create!(
    user_id: user.id,
    title: titles[i],
    body: bodies[i],
    created_at: dates[i],
    updated_at: dates[i]
  )
end

# りんご愛好家ユーザーによる投稿（1人1件ずつ）
User.where("name LIKE ?", "りんご愛好家%").each_with_index do |user, i|
  titles = [
    "りんごジャム作りに挑戦",
    "酸味が強い品種が好き",
    "家庭菜園でりんごを育てたい",
    "蜜入りりんごの見分け方",
    "アップルパイが止まらない",
    "青森のりんご狩り体験",
    "紅玉のシャキシャキ感最高",
    "品種ごとの味比べにハマる",
    "農家の方の話を聞いて",
    "直売でりんごをゲット！美味〜"
  ]

  dates = [
    Time.new(2024, 9, 1),
    Time.new(2024, 10, 5),
    Time.new(2024, 3, 10),
    Time.new(2024, 10, 15),
    Time.new(2024, 1, 20),
    Time.new(2024, 9, 25),
    Time.new(2024, 3, 30),
    Time.new(2024, 8, 5),
    Time.new(2024, 7, 10),
    Time.new(2024, 9, 25)
  ]
  
  bodies = [
    "最近ジャム作りにハマっていて、今回はふじを使ってみました。甘さと酸味のバランスがちょうどよくて大満足！",
    "甘いりんごもいいけど、私は酸味の強い品種が好き。最近のお気に入りは『ジョナゴールド』。",
    "マンション暮らしだけど、ベランダで小さなりんごの木を育ててみたい。鉢植えで実がなる品種を探し中！",
    "蜜入りのりんごが大好き。最近覚えたのは、お尻の部分が黄色いほど蜜が多いらしい。見極めが楽しい！",
    "休日にアップルパイを焼くのが楽しみ。紅玉の酸味がバターと合う！家中がりんごの香りになるのも幸せ。",
    "青森の山の上農園でりんご狩りを体験。農家さんに直接教えてもらった収穫のコツがすごく面白かった。",
    "紅玉のあのシャキッとした食感、たまらない！そのまま食べても、料理にしても万能な品種です。",
    "ついついスーパーで品種ごとの食べ比べセットを買ってしまう。味の違いがわかってきて楽しい！",
    "先日、アオモリンゴラボのイベントでりんご農家さんのお話を聞く機会があり、りんご1つ作るのにどれだけ手間がかかっているか知って驚きました。",
    "アオモリンゴラボの山の上農園さんの投稿で直売しているというのを聞いて早速道の駅へ行ってきました！ふじ、蜜たっぷりで美味。幸せ〜。"
  ]

  Post.create!(
    user_id: user.id,
    title: titles[i],
    body: bodies[i],
    created_at: dates[i],
    updated_at: dates[i]
  )
end
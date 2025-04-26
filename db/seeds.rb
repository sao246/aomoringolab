# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ログインアカウント作成
Admin.create!(
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# 農家・企業ユーザー作成
farmers = [
  { name: "頑張る農家", email: "farmer1@email", introduction: "弘前市で農家をやっています。" },
  { name: "農家はなこ", email: "farmer2@email", introduction: "黒石市で農家をやっています。" },
  { name: "山の上農園", email: "farmer3@email", introduction: "西目屋村でりんご農園を営んでいます。（直通）電話番号：01xx-xx-xx" },
  { name: "石川農園", email: "farmer4@email", introduction: "平川市のりんご農園です。直売所あります。お問い合わせは（直通）電話番号：01xx-xx-xx までよろしくお願いいたします。"},
  { name: "りんご一筋", email: "farmer5@email", introduction: "板柳町の農家です。" },
  { name: "安全りんご農園", email: "farmer6@email", introduction: "無農薬・無化学肥料の栽培に挑戦しづけます！弘前のりんご農園です。（直通）01xx-xx-xx" },
  { name: "ナチュラルファーム", email: "farmer7@email", introduction: "自然のままに。美味しいりんごをお届けします！平川市のりんご農家です。（直通）01xx-xx-xx" },
  { name: "スイーツ農園", email: "farmer8@email", introduction: "自然で美味しいりんごを大事に育てます。平川市のりんご農家です。（直通）01xx-xx-xx" },
  { name: "株式会社りんごワールド", email: "farmer9@email", introduction: "日本の美味しい果物を世界に！東京都の青果輸出企業です。HPはこちら：https://xxx.com" }
]

# ここでDBに登録。（画像添付も行う）
farmers.each do |user_data|
  # メールアドレスの先頭部分（@の前）を取り出して、それに"password"を追加
  user_prefix = user_data[:email].split('@').first
  generated_password = "#{user_prefix}password"
  
  # ユーザー作成
  user = User.create!(user_data.merge(password: generated_password))  
  puts "Created #{user.name} with password: #{generated_password}"  # 作成したユーザーとそのパスワードを表示
  
  # プロフィール画像を添付
  image_path = Rails.root.join("app", "assets", "images", "#{user_prefix}_profile.jpg")
  if File.exist?(image_path)
    user.profile_image.attach(io: File.open(image_path), filename: "#{user_prefix}_profile.jpg")
    puts "Attached profile image for #{user.name}"
  else
    puts "No profile image found for #{user.name}"
  end
end

# 愛好家ユーザー作成
fans = [
  { name: "りんご大好き子", email: "fan1@email", introduction: "東京都在住ですが青森大好き！りんごスイーツに興味あり" },
  { name: "ご当地マニア", email: "fan2@email", introduction: "青森在住歴ありりんごの品種マスターです。神奈川県在住" },
  { name: "りんご大好きカメラマン", email: "fan3@email", introduction: "写真が趣味。千葉県住みですが青森を旅行してはりんご農家さんにお邪魔しています。" },
  { name: "りんご親子", email: "fan4@email", introduction: "弘前市の主婦です。子供にも農体験をさせたく親子でチャレンジ中" },
  { name: "りんごソムリエ", email: "fan5@email", introduction: "板柳在住。りんごの食べ比べが趣味です。甘味酸味などにうるさいです笑" },
  { name: "りんご留学生", email: "fan6@email", introduction: "台湾から来ました。大学で留学しています。りんご生産に興味あり、農家のお手伝いをしています。" },
  { name: "りんごマニア", email: "fan7@email", introduction: "台湾在住りんご大好き！" },
  { name: "りんごマン", email: "fan8@email", introduction: "青い森大学の学生です。東京から来ました。" }
]

# ここでDBに登録。（画像添付も行う）
fans.each do |user_data|
  # メールアドレスの先頭部分（@の前）を取り出して、それに"password"を追加
  user_prefix = user_data[:email].split('@').first
  generated_password = "#{user_prefix}password"  # 例: "fan1password"
  
  # ユーザー作成
  user = User.create!(user_data.merge(password: generated_password))  
  puts "Created #{user.name} with password: #{generated_password}"  # 作成したユーザーとそのパスワードを表示
  
  # プロフィール画像を添付
  image_path = Rails.root.join("app", "assets", "images", "#{user_prefix}_profile.jpg")
  if File.exist?(image_path)
    user.profile_image.attach(io: File.open(image_path), filename: "#{user_prefix}_profile.jpg")
    puts "Attached profile image for #{user.name}"
  end
end

# 投稿・投稿コメントデータの作成
# 農家のアカウントをDB登録順に変数格納。（[]配列要素番号は0から）
farmer_users = User.where("email LIKE ?", "farmer%").order(:id)

# 愛好家のアカウントをDB登録順に変数格納。（[]配列要素番号は0から）
fan_users = User.where("email LIKE ?", "fan%").order(:id)

# タグ作成
tag1 = Tag.find_or_create_by(name: "りんご")
tag2 = Tag.find_or_create_by(name: "りんご農家")
tag3 = Tag.find_or_create_by(name: "ふじ")
tag4 = Tag.find_or_create_by(name: "王林")
tag5 = Tag.find_or_create_by(name: "つがる")
tag6 = Tag.find_or_create_by(name: "ジョナゴールド")
tag7 = Tag.find_or_create_by(name: "サンふじ")
tag8 = Tag.find_or_create_by(name: "とき")
tag9 = Tag.find_or_create_by(name: "彩香")
tag10 = Tag.find_or_create_by(name: "スターキングデリシャス")
tag11 = Tag.find_or_create_by(name: "摘果")
tag12 = Tag.find_or_create_by(name: "害虫対策")
tag13 = Tag.find_or_create_by(name: "収穫")
tag14 = Tag.find_or_create_by(name: "ミツバチ")
tag15 = Tag.find_or_create_by(name: "受粉")
tag16 = Tag.find_or_create_by(name: "台湾のりんご")
tag17 = Tag.find_or_create_by(name: "収穫体験")
tag18 = Tag.find_or_create_by(name: "蜜りんご")
tag19 = Tag.find_or_create_by(name: "直売")
tag20 = Tag.find_or_create_by(name: "マメコバチ")
tag21 = Tag.find_or_create_by(name: "無農薬栽培")
tag22 = Tag.find_or_create_by(name: "農園")
tag23 = Tag.find_or_create_by(name: "岩木山")
tag24 = Tag.find_or_create_by(name: "りんご畑")
tag25 = Tag.find_or_create_by(name: "収穫手伝い")
tag26 = Tag.find_or_create_by(name: "りんご輸出")
tag27 = Tag.find_or_create_by(name: "アップルパイ")
tag28 = Tag.find_or_create_by(name: "霜対策")
tag29 = Tag.find_or_create_by(name: "りんご農家の一年")
tag30 = Tag.find_or_create_by(name: "りんご農家の手仕事")
tag31 = Tag.find_or_create_by(name: "施肥")
tag32 = Tag.find_or_create_by(name: "弘前")
tag33 = Tag.find_or_create_by(name: "板柳")
tag34 = Tag.find_or_create_by(name: "西目屋")
tag35 = Tag.find_or_create_by(name: "りんごジャム")
tag36 = Tag.find_or_create_by(name: "りんごジュース")
tag37 = Tag.find_or_create_by(name: "タルトタタン")
tag38 = Tag.find_or_create_by(name: "シードル")
tag39 = Tag.find_or_create_by(name: "アップルティー")
tag40 = Tag.find_or_create_by(name: "りんごスイーツ")
tag41 = Tag.find_or_create_by(name: "食べ比べ")
tag42 = Tag.find_or_create_by(name: "アオモリンゴラボ企画")
tag43 = Tag.find_or_create_by(name: "美味しい")
tag44 = Tag.find_or_create_by(name: "農作業体験")
tag45 = Tag.find_or_create_by(name: "絶品レシピ")
tag46 = Tag.find_or_create_by(name: "枝剪定")
tag47 = Tag.find_or_create_by(name: "選果")
tag48 = Tag.find_or_create_by(name: "実まわし")
tag49 = Tag.find_or_create_by(name: "袋かけ")
tag50 = Tag.find_or_create_by(name: "作業手伝い募集！")
tag51 = Tag.find_or_create_by(name: "草刈り")

# 投稿１
post1 = Post.create!(
  user_id: farmer_users[0].id,
  title: "摘果作業が始まりました",
  body: "GWも終わり、今年もいよいよ摘果作業の季節。無駄な実を落とすことで、残ったりんごがしっかり育ってくれます。",
  created_at: Time.new(2024, 6, 15),
  updated_at: Time.new(2024, 6, 15)
)
# タグ
post1.tags << tag2
post1.tags << tag3
post1.tags << tag11
post1.tags << tag29
post1.tags << tag30
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post1)
Favorite.create!(user_id: fan_users[0].id, post: post1)
Favorite.create!(user_id: fan_users[4].id, post: post1)
# 画像添付
image_path = Rails.root.join("app", "assets", "images", "tekika.jpg")
if File.exist?(image_path)
  post1.image.attach(io: File.open(image_path), filename: "tekika.jpg")
  puts "Image attached to post 1"
end
# コメントを追加
Comment.create!(
  post: post1,
  user_id: fan_users[0].id,
  body: "摘果作業がうまくいくと良いですね！毎年応援しています！",
  created_at: Time.new(2024, 6, 16),
  updated_at: Time.new(2024, 6, 16)
)
Comment.create!(
  post: post1,
  user_id: fan_users[4].id,
  body: "無駄な実を落とすことで美味しいりんごが作られているんですね！",
  created_at: Time.new(2024, 6, 16),
  updated_at: Time.new(2024, 6, 16)
)

# 投稿２
post2 = Post.create!(
  user_id: farmer_users[1].id,
  title: "害虫対策奮闘中",
  body: "こんにちは。先日農作業の合間にお休みを取って弘前公園へ行ってきました。弘前の桜は最高ですね。今年はカメムシが多くて葉っぱに被害が出ています。防除のタイミングが重要で、例年以上に気を使っています。写真はカメムシ、ではなく桜の綺麗な写真です笑",
  created_at: Time.new(2025, 4, 25),
  updated_at: Time.new(2025, 4, 25)
)
# タグ
post2.tags << tag4
post2.tags << tag12
post2.tags << tag18
post2.tags << tag29
post2.tags << tag30
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post2)
Favorite.create!(user_id: farmer_users[4].id, post: post2)
Favorite.create!(user_id: fan_users[3].id, post: post2)
# 画像添付
image_path = Rails.root.join("app", "assets", "images", "hirosaki1.jpg")
if File.exist?(image_path)
  post2.image.attach(io: File.open(image_path), filename: "hirosaki1.jpg")
  puts "Image attached to post 2"
end
# コメントを追加
Comment.create!(
  post: post2,
  user_id: fan_users[3].id,
  body: "害虫対策がしっかりしているので安心です。今年も美味しいりんごを楽しみにしています!!頑張って下さい〜",
  created_at: Time.new(2025, 4, 26),
  updated_at: Time.new(2025, 4, 26)
)
Comment.create!(
  post: post2,
  user_id: farmer_users[0].id,
  body: "今年は例年に比べて多いですね。互いに頑張りましょう！！",
  created_at: Time.new(2025, 4, 26),
  updated_at: Time.new(2025, 4, 26)
)

# 投稿３：
post3 = Post.create!(
  user_id: farmer_users[4].id,
  title: "霜対策・ミツバチとの共生",
  body: "霜対策には防霜ファンと囲いを活用しています。ミツバチとの共生が作物の品質にも大きく影響します。",
  created_at: Time.new(2025, 3, 10),
  updated_at: Time.new(2025, 3, 10)
)
# タグ
post3.tags << tag14
post3.tags << tag20
post3.tags << tag28
post3.tags << tag29
post3.tags << tag30
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post3)
Favorite.create!(user_id: farmer_users[5].id, post: post3)
Favorite.create!(user_id: farmer_users[7].id, post: post3)
Favorite.create!(user_id: fan_users[4].id, post: post3)
Favorite.create!(user_id: fan_users[7].id, post: post3)
# コメントを追加
Comment.create!(
  post: post3,
  user_id: fan_users[4].id,
  body: "ミツバチとの共生についてもっと知りたいです！自然派農法に感動しています。",
  created_at: Time.new(2025, 3, 11),
  updated_at: Time.new(2025, 3, 11)
)
Comment.create!(
  post: post3,
  user_id: fan_users[7].id,
  body: "大学でりんごの研究をしており、お話をぜひ伺いたいです！霜対策のお手伝いができるかもしれません。",
  created_at: Time.new(2025, 3, 11),
  updated_at: Time.new(2025, 3, 11)
)


# 投稿４：
post4 = Post.create!(
  user_id: farmer_users[3].id,
  title: "農作業体験いかがですか？",
  body: "石川農園ではりんごの収穫体験もできます。美味しい蜜りんごがその場で召し上がれます！体験は9月15日頃より開始予定です。詳しくはプロフィールのお問合せ先よりご連絡ください。皆さんのご参加お待ちしております〜！",
  created_at: Time.new(2024, 8, 15),
  updated_at: Time.new(2024, 8, 15)
)
# タグ
post4.tags << tag17
post4.tags << tag18
post4.tags << tag25
# いいね登録
Favorite.create!(user_id: farmer_users[2].id, post: post4)
Favorite.create!(user_id: fan_users[0].id, post: post4)
Favorite.create!(user_id: fan_users[3].id, post: post4)
Favorite.create!(user_id: fan_users[5].id, post: post4)
Favorite.create!(user_id: fan_users[7].id, post: post4)
# コメントを追加
Comment.create!(
  post: post4,
  user_id: fan_users[3].id,
  body: "収穫体験興味あります！！子供を参加させたいです。",
  created_at: Time.new(2024, 8, 16),
  updated_at: Time.new(2024, 8, 16)
)
Comment.create!(
  post: post4,
  user_id: fan_users[0].id,
  body: "行ってみようかな〜",
  created_at: Time.new(2024, 8, 16),
  updated_at: Time.new(2024, 8, 16)
)

# 投稿５：
post5 = Post.create!(
  user_id: farmer_users[2].id,
  title: "色付きチェック・糖度チェック",
  body: "今年のりんごは色付きも良好で、糖度も順調に上がっています。もう少しで収穫です。9月25日から道の駅つがるにて直売も開始します！直売情報はリンゴラボの投稿でもお知らせいたします。",
  created_at: Time.new(2024, 9, 20),
  updated_at: Time.new(2024, 9, 20)
)
# タグ
post5.tags << tag3
post5.tags << tag5
post5.tags << tag18
post5.tags << tag19
# いいね登録
Favorite.create!(user_id: farmer_users[3].id, post: post5)
Favorite.create!(user_id: farmer_users[7].id, post: post5)
Favorite.create!(user_id: fan_users[3].id, post: post5)
Favorite.create!(user_id: fan_users[4].id, post: post5)
Favorite.create!(user_id: fan_users[5].id, post: post5)
Favorite.create!(user_id: fan_users[7].id, post: post5)
# 画像添付
image_path = Rails.root.join("app", "assets", "images", "chokubaijo.jpg")
if File.exist?(image_path)
  post5.image.attach(io: File.open(image_path), filename: "chokubaijo.jpg")
  puts "Image attached to post 5"
end
# コメントを追加
Comment.create!(
  post: post5,
  user_id: fan_users[2].id,
  body: "美味しいりんごが収穫できることを楽しみにしています！今年も大きく育ってください。",
  created_at: Time.new(2024, 9, 21),
  updated_at: Time.new(2024, 9, 21)
)

# 投稿６：
post6 = Post.create!(
  user_id: farmer_users[3].id,
  title: "マメコバチの受粉",
  body: "こんにちは、山の上農園です。
りんごの花が満開のこの季節、僕らの畑では“マメコバチ”たちが大活躍中です。
ミツバチに比べて体は小さいけれど、働きぶりはすごいんです。
マメコバチは花の近くを地道にコツコツまわって、確実に受粉してくれます。
特に寒い日や曇りの日でも動いてくれるのがありがたい。
最近はミツバチの数が減ってきていることもあり、こういう在来種の存在がますます大事になってきてます。
ちなみに、マメコバチは刺さないので人にも優しい！
受粉の手助けをしてくれる小さなヒーローたちに感謝しながら、今日もりんごの花を見守ってます。",
  created_at: Time.new(2024, 5, 1),
  updated_at: Time.new(2024, 5, 1)
)
image_path = Rails.root.join("app", "assets", "images", "aomoringolab_other1.jpg")
if File.exist?(image_path)
  post6.image.attach(io: File.open(image_path), filename: "aomoringolab_other1.jpg")
  puts "Image attached to post 6"
end
# タグ
post6.tags << tag2
post6.tags << tag5
post6.tags << tag7
post6.tags << tag15
post6.tags << tag20
post6.tags << tag30
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post6)
Favorite.create!(user_id: fan_users[3].id, post: post6)
Favorite.create!(user_id: fan_users[4].id, post: post6)
# コメントを追加
Comment.create!(
  post: post6,
  user_id: fan_users[3].id,
  body: "受粉にはマメコバチが働いてくれてるんですね！子供にも教えたいと思います！",
  created_at: Time.new(2024, 5, 2),
  updated_at: Time.new(2024, 5, 2)
)
Comment.create!(
  post: post6,
  user_id: fan_users[4].id,
  body: "さすがマメコバチ。働き蜂ですね〜りんごを支えてます。",
  created_at: Time.new(2024, 5, 2),
  updated_at: Time.new(2024, 5, 2)
)

# 投稿７：
post7 = Post.create!(
  user_id: farmer_users[5].id,
  title: "安心りんご栽培のために",
  body: "今年も無事に施肥が完了しました。当農園では、化学肥料、化学農薬を一切使わず栽培を行っています。特に、春先の「施肥」作業は重要で、土壌に優しい有機肥料を使って健康な土作りをしています。その結果、皮ごと食べられる安心で美味しいりんご作りができています。",
  created_at: Time.new(2025, 4, 1),
  updated_at: Time.new(2025, 4, 1)
)
# タグ
post7.tags << tag2
post7.tags << tag3
post7.tags << tag21
post7.tags << tag31
# いいね登録
Favorite.create!(user_id: farmer_users[3].id, post: post7)
Favorite.create!(user_id: farmer_users[6].id, post: post7)
Favorite.create!(user_id: fan_users[3].id, post: post7)
Favorite.create!(user_id: fan_users[4].id, post: post7)
Favorite.create!(user_id: fan_users[6].id, post: post7)
# コメントを追加
Comment.create!(
  post: post7,
  user_id: fan_users[4].id, 
  body: "今年も美味しいりんご楽しみにしています！",
  created_at: Time.new(2025, 4, 2),
  updated_at: Time.new(2025, 4, 2)
)

# 投稿８：
post8 = Post.create!(
  user_id: fan_users[0].id,
  title: "アップルパイは弘前で決まり！",
  body: "久々に弘前を訪れました！3軒はしごして食べ比べしてみました。ふじを使ったタイプが美味しかったです〜。",
  created_at: Time.new(2024, 5, 15),
  updated_at: Time.new(2024, 5, 15)
)
# 画像添付
image_path = Rails.root.join("app", "assets", "images", "applepie.jpg")
if File.exist?(image_path)
  post8.image.attach(io: File.open(image_path), filename: "applepie.jpg")
  puts "Image attached to post 8"
end
# タグ
post8.tags << tag3
post8.tags << tag27
post8.tags << tag32
post8.tags << tag40
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post8)
Favorite.create!(user_id: fan_users[1].id, post: post8)
Favorite.create!(user_id: fan_users[4].id, post: post8)
Favorite.create!(user_id: fan_users[5].id, post: post8)
# コメントを追加
Comment.create!(
  post: post8,
  user_id: fan_users[4].id, # 愛好家ユーザーID
  body: "ふじのアップルパイ、美味しそう！私も行ってみます〜！",
  created_at: Time.new(2024, 5, 16),
  updated_at: Time.new(2024, 5, 16)
)

# 投稿９：
post9 = Post.create!(
  user_id: fan_users[4].id,
  title: "珍しい品種の食べ比べ会レポ",
  body: "アオモリンゴラボのイベント食べ比べ会に今年も参加してきました！スターキングデリシャス・彩香・ジョナゴールド、どれも個性があって面白い！あと新作シードルも試飲させてもらいました。美味しい。",
  created_at: Time.new(2024, 9, 30),
  updated_at: Time.new(2024, 9, 30)
)
# タグ
post9.tags << tag6
post9.tags << tag9
post9.tags << tag38
post9.tags << tag41
post9.tags << tag42
post9.tags << tag43
# いいね登録
Favorite.create!(user_id: farmer_users[7].id, post: post9)
Favorite.create!(user_id: farmer_users[8].id, post: post9)
Favorite.create!(user_id: fan_users[1].id, post: post9)
Favorite.create!(user_id: fan_users[3].id, post: post9)
Favorite.create!(user_id: fan_users[5].id, post: post9)
Favorite.create!(user_id: fan_users[7].id, post: post9)
# コメントを追加
Comment.create!(
  post: post9,
  user_id: farmer_users[1].id,
  body: "品種ごとの違いを知るのは面白いですね！",
  created_at: Time.new(2024, 10, 1),
  updated_at: Time.new(2024, 10, 1)
)
Comment.create!(
  post: post9,
  user_id: farmer_users[7].id,
  body: "そんなイベントがあったとは！見逃しました、残念。",
  created_at: Time.new(2024, 10, 1),
  updated_at: Time.new(2024, 10, 1)
)

# 投稿１０：
post10 = Post.create!(
  user_id: fan_users[2].id,
  title: "岩木山とりんご畑",
  body: "このアングルからの岩木山とりんご畑の組み合わせは絶景そのもの。今年も来れて良かった。山の上農園さんにお世話になっています。",
  created_at: Time.new(2024, 10, 20),
  updated_at: Time.new(2024, 10, 20)
)
# タグ
post10.tags << tag2
post10.tags << tag4
post10.tags << tag13
post10.tags << tag23
post10.tags << tag29
post10.tags << tag30
post10.tags << tag34
# 画像添付
image_path = Rails.root.join("app", "assets", "images", "mt_iwaki.jpg")
if File.exist?(image_path)
  post10.image.attach(io: File.open(image_path), filename: "mt_iwaki.jpg")
  puts "Image attached to post 3"
end
# いいね登録
Favorite.create!(user_id: farmer_users[2].id, post: post10)
Favorite.create!(user_id: fan_users[0].id, post: post10)
Favorite.create!(user_id: fan_users[1].id, post: post10)
Favorite.create!(user_id: fan_users[3].id, post: post10)
Favorite.create!(user_id: fan_users[6].id, post: post10)
# コメントを追加
Comment.create!(
  post: post10,
  user_id: fan_users[1].id,
  body: "岩木山素敵ですね。さすが津軽富士。",
  created_at: Time.new(2024, 10, 21),
  updated_at: Time.new(2024, 10, 21)
)
Comment.create!(
  post: post10,
  user_id: farmer_users[2].id,
  body: "今年もお越しいただきありがとうございました！こうして農家の作業に興味を持っていただき大変感謝しております。",
  created_at: Time.new(2024, 10, 22),
  updated_at: Time.new(2024, 10, 22)
)

# 投稿１１：
post11 = Post.create!(
  user_id: fan_users[3].id,
  title: "農業体験で子供も大興奮",
  body: "石川農園さんにて収穫体験させていただきました。子供も終始楽しく作業！一緒にりんごの重さも測りました。りんごジュースも作っているそうで、自家製のジュースをいただきました。嬉しい！",
  created_at: Time.new(2024, 9, 30),
  updated_at: Time.new(2024, 9, 30)
)
# タグ
post11.tags << tag3
post11.tags << tag7
post11.tags << tag8
post11.tags << tag13
post11.tags << tag17
post11.tags << tag36
post11.tags << tag43
# いいね登録
Favorite.create!(user_id: fan_users[5].id, post: post11)
Favorite.create!(user_id: fan_users[6].id, post: post11)
Favorite.create!(user_id: farmer_users[3].id, post: post11)
Favorite.create!(user_id: farmer_users[4].id, post: post11)
Favorite.create!(user_id: farmer_users[8].id, post: post11)
# コメントを追加
Comment.create!(
  post: post11,
  user_id: farmer_users[4].id,
  body: "農業体験、楽しそうですね！子供たちにも農業の楽しさが伝わるはず。",
  created_at: Time.new(2024, 10, 1),
  updated_at: Time.new(2024, 10, 1)
)
Comment.create!(
  post: post11,
  user_id: farmer_users[3].id,
  body: "りんご親子さん、先日は収穫体験にご参加いただきありがとうございました。楽しく作業いただいたようで私も嬉しいです。",
  created_at: Time.new(2024, 10, 2),
  updated_at: Time.new(2024, 10, 2)
)

# 投稿１２：
post12 = Post.create!(
  user_id: fan_users[1].id,
  title: "王林の香りが好き",
  body: "他のりんごにはない独特の芳香、ついついリピ買いしちゃいます。アップルパイも作ろうかな。いいレシピがあれば教えて下さい〜",
  created_at: Time.new(2024, 12, 20),
  updated_at: Time.new(2024, 12, 20)
)
# タグ
post12.tags << tag4
post12.tags << tag27
post12.tags << tag40
post12.tags << tag45
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post12)
Favorite.create!(user_id: farmer_users[4].id, post: post12)
Favorite.create!(user_id: fan_users[0].id, post: post12)
Favorite.create!(user_id: fan_users[3].id, post: post12)
# コメントを追加
Comment.create!(
  post: post12,
  user_id: farmer_users[4].id,
  body: "王林、私も大好きです！香りが本当に魅力的ですよね。",
  created_at: Time.new(2024, 12, 21),
  updated_at: Time.new(2024, 12, 22)
)
Comment.create!(
  post: post12,
  user_id: fan_users[0].id,
  body: "いいレシピありますよ！",
  created_at: Time.new(2024, 12, 21),
  updated_at: Time.new(2024, 12, 22)
)

# 投稿１３：
post13 = Post.create!(
  user_id: fan_users[5].id,
  title: "農家のボランティア",
  body: "リンゴラボの投稿を見て、山の上農園さんにお手伝いに行きました。台湾でもりんごは人気ですがその生産はたくさんの努力があったことを初めて学びました。弘前のりんご農家さんの丁寧な作業あっての美味しいりんごなのだと改めて感じました。",
  created_at: Time.new(2024, 10, 10),
  updated_at: Time.new(2024, 10, 10)
)
# タグ
post13.tags << tag30
post13.tags << tag42
post13.tags << tag16
post13.tags << tag25
post13.tags << tag26
post13.tags << tag17
# いいね登録
Favorite.create!(user_id: farmer_users[2].id, post: post13)
Favorite.create!(user_id: farmer_users[8].id, post: post13)
Favorite.create!(user_id: fan_users[0].id, post: post13)
Favorite.create!(user_id: fan_users[1].id, post: post13)
Favorite.create!(user_id: fan_users[3].id, post: post13)
# コメントを追加
Comment.create!(
  post: post13,
  user_id: farmer_users[4].id,
  body: "日本の農家の手作業の丁寧さを素晴らしいと言ってもらえて農家として誇らしいです。勉強頑張って下さいね。",
  created_at: Time.new(2024, 10, 11),
  updated_at: Time.new(2024, 10, 11)
)

# 投稿１4：
post14 = Post.create!(
  user_id: farmer_users[0].id,
  title: "枝剪定",
  body: "雪もだいぶ解け始め、今年もりんごの枝剪定の時期がやってきました。腰が痛いですが、頑張って作業するぞ！",
  created_at: Time.new(2025, 3, 10),
  updated_at: Time.new(2025, 3, 10)
)
# タグ
post14.tags << tag46
post14.tags << tag2
post14.tags << tag29
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post14)
Favorite.create!(user_id: farmer_users[2].id, post: post14)
Favorite.create!(user_id: farmer_users[3].id, post: post14)
Favorite.create!(user_id: fan_users[1].id, post: post14)
Favorite.create!(user_id: fan_users[2].id, post: post14)
Favorite.create!(user_id: fan_users[4].id, post: post14)
# コメントを追加
Comment.create!(
  post: post14,
  user_id: farmer_users[1].id,
  body: "枝剪定の時期ですね！うちも始めました。冬の間になまってしまった体を動かします〜笑！",
  created_at: Time.new(2025, 3, 11),
  updated_at: Time.new(2025, 3, 11)
)

post15 = Post.create!(
  user_id: fan_users[0].id,
  title: "アップルパイの絶品レシピ紹介します",
  body: "最近アップルパイのレシピ研究してます！！今日は好評だったふじを使った美味しいレシピを紹介します。甘さ控えめでスイーツ苦手な人にもおすすめ！
  材料：ふじりんご（２個）、砂糖（30g）、パイシート（２枚）、無塩バター（20g）、薄力粉（少々）、溶き卵（少々）
  りんごはみじん切りにし、鍋に投入、砂糖を加えて30分程度置いたあと、10分程度煮混んでジャム状になったら火からおろします。
  パイシートをグラタン皿に敷き、その上にりんごジャムを入れます。パイシートをさらに被せて溶き卵を表面に塗り、200度のオーブンで20分程度焼きます。
  簡単に美味しくできるレシピです！",
  created_at: Time.new(2025, 2, 5),
  updated_at: Time.new(2025, 2, 5)
)
# タグ
post15.tags << tag46
post15.tags << tag2
post15.tags << tag29
# いいね登録
Favorite.create!(user_id: farmer_users[1].id, post: post15)
Favorite.create!(user_id: farmer_users[7].id, post: post15)
Favorite.create!(user_id: fan_users[1].id, post: post15)
Favorite.create!(user_id: fan_users[3].id, post: post15)
Favorite.create!(user_id: fan_users[5].id, post: post15)
# コメントを追加
Comment.create!(
  post: post15,
  user_id: fan_users[1].id,
  body: "美味しそう！自分もやってみます！レシピ探してたから嬉しい。",
  created_at: Time.new(2025, 2, 10),
  updated_at: Time.new(2025, 2, 10)
)

# 投稿１６
post16 = Post.create!(
  user_id: farmer_users[4].id,
  title: "選果も終わりに近づきました",
  body: "今年の選果作業もシーズンオフに近づきました。天候に恵まれ形・色づきともに例年になくいい出来です！道の駅「いたやなぎ」の直売所にも売り出していますのでみなさんたくさん食べてくださいね。",
  created_at: Time.new(2024, 11, 5),
  updated_at: Time.new(2024, 11, 5)
)
# タグ
post16.tags << tag47
post16.tags << tag2
post16.tags << tag3
post16.tags << tag8
post16.tags << tag19
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post16)
Favorite.create!(user_id: farmer_users[1].id, post: post16)
Favorite.create!(user_id: farmer_users[2].id, post: post16)
Favorite.create!(user_id: fan_users[3].id, post: post16)
Favorite.create!(user_id: fan_users[4].id, post: post16)
Favorite.create!(user_id: fan_users[5].id, post: post16)
Favorite.create!(user_id: fan_users[7].id, post: post16)
# コメントを追加
Comment.create!(
  post: post16,
  user_id: fan_users[0].id,
  body: "私のところももうそろそろ終わりです。お疲れ様でした！もう少し頑張りましょ!",
  created_at: Time.new(2024, 11, 6),
  updated_at: Time.new(2024, 11, 6)
)

# 投稿１７
post17 = Post.create!(
  user_id: farmer_users[1].id,
  title: "実まわし頑張るぞ",
  body: "りんごに綺麗に色がつくよう、実まわしを行なって、お日様の光がまんべんなくりんごに当たるように作業しています。もう1ヶ月もすれば収穫の時期になります。もう少し！頑張るぞー！",
  created_at: Time.new(2024, 8, 5),
  updated_at: Time.new(2024, 8, 5)
)
# タグ
post17.tags << tag48
post17.tags << tag7
post17.tags << tag3
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post17)
Favorite.create!(user_id: farmer_users[2].id, post: post17)
Favorite.create!(user_id: farmer_users[4].id, post: post17)
Favorite.create!(user_id: fan_users[3].id, post: post17)
Favorite.create!(user_id: fan_users[5].id, post: post17)
Favorite.create!(user_id: fan_users[7].id, post: post17)
# コメントを追加
Comment.create!(
  post: post17,
  user_id: fan_users[0].id,
  body: "実まわしの時期ですね！",
  created_at: Time.new(2024, 8, 6),
  updated_at: Time.new(2024, 8, 6)
)

# 投稿１８
post18 = Post.create!(
  user_id: farmer_users[1].id,
  title: "タルトタタン作りに挑戦！",
  body: "アオモリンゴラボのイベントで、タルトタタン作りに挑戦しました！！キャラメリゼ難しいけどできたら美味しかった〜家でも再挑戦したいな。",
  created_at: Time.new(2025, 1, 15),
  updated_at: Time.new(2025, 1, 15)
)
# タグ
post18.tags << tag42
post18.tags << tag37
post18.tags << tag9
post18.tags << tag18
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post18)
Favorite.create!(user_id: farmer_users[2].id, post: post18)
Favorite.create!(user_id: farmer_users[4].id, post: post18)
Favorite.create!(user_id: fan_users[1].id, post: post18)
Favorite.create!(user_id: fan_users[3].id, post: post18)
Favorite.create!(user_id: fan_users[5].id, post: post18)
Favorite.create!(user_id: fan_users[7].id, post: post18)
# コメントを追加
Comment.create!(
  post: post18,
  user_id: fan_users[7].id,
  body: "楽しかったですね〜",
  created_at: Time.new(2025, 1, 16),
  updated_at: Time.new(2025, 1, 16)
)

# 投稿１９
post19 = Post.create!(
  user_id: farmer_users[4].id,
  title: "袋かけが始まりました！",
  body: "袋かけをやっています。例年親戚に手伝いに来てもらっているのですが、今年は予定が合わず袋かけを手伝ってくれる人が足りていません。
  アオモリンゴラボ愛好ユーザーの皆様、どなたかお手伝いしてくれませんか。詳しくはコメント欄にてご連絡ください！よろしくお願いします。",
  created_at: Time.new(2024, 7, 15),
  updated_at: Time.new(2024, 7, 15)
)
# タグ
post19.tags << tag49
post19.tags << tag50
post19.tags << tag22
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post19)
Favorite.create!(user_id: farmer_users[1].id, post: post19)
Favorite.create!(user_id: farmer_users[2].id, post: post19)
Favorite.create!(user_id: fan_users[5].id, post: post19)
Favorite.create!(user_id: fan_users[7].id, post: post19)
Favorite.create!(user_id: fan_users[3].id, post: post19)
Favorite.create!(user_id: fan_users[6].id, post: post19)
# コメントを追加
Comment.create!(
  post: post19,
  user_id: fan_users[5].id,
  body: "来週なら行けるかもしれません！お電話します。",
  created_at: Time.new(2025, 1, 16),
  updated_at: Time.new(2025, 1, 16)
)
Comment.create!(
  post: post19,
  user_id: fan_users[5].id,
  body: "7月20日〜23日なら空いてます〜！",
  created_at: Time.new(2025, 1, 16),
  updated_at: Time.new(2025, 1, 16)
)

# 投稿２０
post20 = Post.create!(
  user_id: farmer_users[8].id,
  title: "今年収穫したてのりんごシードル",
  body: "毎年恒例、山の上農園さんとのコラボ企画で、シードルの試飲会を開催いたします。山の上農園さんはシードル工場を自ら開設し、お酒の開発・販売を行っています！
  日時は2024年12月5日を予定。詳細は追って発表します。先着順数量限定での試飲会となりますが、みなさんのご参加をお待ちしています！",
  created_at: Time.new(2024, 11, 15),
  updated_at: Time.new(2024, 11, 15)
)
# タグ
post20.tags << tag38
post20.tags << tag42
post20.tags << tag43
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post20)
Favorite.create!(user_id: farmer_users[1].id, post: post20)
Favorite.create!(user_id: farmer_users[2].id, post: post20)
Favorite.create!(user_id: fan_users[5].id, post: post20)
Favorite.create!(user_id: fan_users[7].id, post: post20)
Favorite.create!(user_id: fan_users[3].id, post: post20)
Favorite.create!(user_id: fan_users[6].id, post: post20)
# コメントを追加
Comment.create!(
  post: post20,
  user_id: fan_users[0].id,
  body: "残念。遠征してでもいいから参加したかった〜。東京に出荷されるのを楽しみに待っています。東京でもやってほしい。",
  created_at: Time.new(2024, 11, 16),
  updated_at: Time.new(2024, 11, 16)
)

# 投稿２１
post21 = Post.create!(
  user_id: farmer_users[1].id,
  title: "急募！草刈り手伝い",
  body: "いつもはおじいちゃんが草刈りをやってくれてるのですが、先日急に腰を痛めてしまって草刈りしてくれる人が不足しています。どなたか草刈りをお手伝いいただけないでしょうか。",
  created_at: Time.new(2024, 8, 15),
  updated_at: Time.new(2024, 8, 15)
)
# タグ
post21.tags << tag24
post21.tags << tag50
post21.tags << tag51
# いいね登録
Favorite.create!(user_id: farmer_users[0].id, post: post21)
Favorite.create!(user_id: farmer_users[1].id, post: post21)
Favorite.create!(user_id: fan_users[4].id, post: post21)
Favorite.create!(user_id: fan_users[5].id, post: post21)
# コメントを追加
Comment.create!(
  post: post21,
  user_id: farmer_users[0].id,
  body: "来週でよければ手伝いに行きましょうか。草刈機あります。",
  created_at: Time.new(2024, 8, 16),
  updated_at: Time.new(2024, 8, 16)
)
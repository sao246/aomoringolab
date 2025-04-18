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
# 農家ユーザー作成
farmers = [
  { name: "頑張る農家", email: "farmer1@email", introduction: "弘前市で農家をやっています。" },
  { name: "農家はなこ", email: "farmer2@email", introduction: "黒石市で農家をやっています。" },
  { name: "山の上農園", email: "farmer3@email", introduction: "西目屋村でりんご農園を営んでいます。（直通）電話番号：01xx-xx-xx" },
  { name: "石川農園", email: "farmer4@email", introduction: "平川市のりんご農園です。直売所あります。お問い合わせは（直通）電話番号：01xx-xx-xx までよろしくお願いいたします。"},
  { name: "りんご一筋", email: "farmer5@email", introduction: "板柳町の農家です。" }
]

farmers.each do |user_data|
  # メールアドレスの先頭部分（@の前）を取り出して、それに"password"を追加
  user_prefix = user_data[:email].split('@').first
  generated_password = "#{user_prefix}password"  # 例: "farmer1password"
  
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
  { name: "りんご留学生", email: "fan6@email", introduction: "台湾から来ました。大学で留学しています。りんご生産に興味あり、農家のお手伝いをしています。" }
]

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

# 投稿
# 愛好家チームの投稿データ
fan_users = User.where("email LIKE ?", "fan%").order(:id)
# 農家太郎（弘前市）の投稿
farmer1 = User.find_by(email: 'farmer1@email') # 農家太郎
post1 = Post.create!(
  user_id: farmer1.id,
  title: "摘果作業が始まりました",
  body: "今年もいよいよ摘果作業の季節。無駄な実を落とすことで、残るりんごがしっかり育ってくれます。",
  created_at: Time.new(2024, 5, 15)
)
image_path = Rails.root.join("app", "assets", "images", "tekika.jpg")
if File.exist?(image_path)
  post1.image.attach(io: File.open(image_path), filename: "tekika.jpg")
  puts "Image attached to post 1"
end

# コメントを追加
Comment.create!(
  post: post1,
  user_id: fan_users[0].id, # 愛好家ユーザーID
  body: "摘果作業がうまくいくと良いですね！毎年応援しています！",
  created_at: Time.new(2024, 5, 16),
  updated_at: Time.new(2024, 5, 16)
)
Comment.create!(
  post: post1,
  user_id: fan_users[4].id, # 愛好家ユーザーID
  body: "無駄な実を落とすことで美味しいりんごが作られているんですね！",
  created_at: Time.new(2024, 5, 16),
  updated_at: Time.new(2024, 5, 16)
)

# 農家花子（黒石市）の投稿
farmer2 = User.find_by(email: 'farmer2@email') # 農家花子
post2 = Post.create!(
  user_id: farmer2.id,
  title: "害虫対策奮闘中",
  body: "今年はカメムシが多くて葉っぱに被害が出ています。防除のタイミングが重要で、例年以上に気を使っています。",
  created_at: Time.new(2024, 4, 25)
)

# コメントを追加
Comment.create!(
  post: post2,
  user_id: fan_users[3].id, # 愛好家ユーザーID
  body: "害虫対策がしっかりしているので安心です。今年も美味しいりんごを楽しみにしています!!頑張って下さい〜",
  created_at: Time.new(2024, 4, 26),
  updated_at: Time.new(2024, 4, 26)
)
Comment.create!(
  post: post2,
  user_id: farmer2.id,
  body: "今年は例年に比べて多いですね。互いに頑張りましょう！！",
  created_at: Time.new(2024, 4, 26),
  updated_at: Time.new(2024, 4, 26)
)

# 山の上農園（西目屋村）の投稿
farmer3 = User.find_by(email: 'farmer3@email') # 山の上農園
post3 = Post.create!(
  user_id: farmer3.id,
  title: "霜対策・ミツバチとの共生",
  body: "霜対策には防霜ファンと囲いを活用しています。ミツバチとの共生が作物の品質にも大きく影響します。",
  created_at: Time.new(2024, 3, 10)
)

# コメントを追加
Comment.create!(
  post: post3,
  user_id: fan_users[4].id, # 愛好家ユーザーID
  body: "ミツバチとの共生についてもっと知りたいです！自然派農法に感動しています。",
  created_at: Time.new(2024, 3, 11),
  updated_at: Time.new(2024, 3, 11)
)

# 石川農園の投稿
farmer4 = User.find_by(email: 'farmer4@email') # 石川農園
post4 = Post.create!(
  user_id: 3,
  title: "子供と一緒の農作業体験いかがですか？",
  body: "今年も子供と一緒に農作業をしています。石川農園ではボランティアでりんごの収穫体験もできます。体験は9月15日頃より開始予定です。詳しくはプロフィールのお問合せ先よりご連絡ください。皆さんのご参加お待ちしております〜！",
  created_at: Time.new(2024, 8, 15)
)

# コメントを追加
Comment.create!(
  post: post4,
  user_id: fan_users[3].id, # 愛好家ユーザーID
  body: "収穫体験興味あります！！子供を参加させたいです。",
  created_at: Time.new(2024, 8, 16),
  updated_at: Time.new(2024, 8, 16)
)
Comment.create!(
  post: post4,
  user_id: fan_users[0].id, # 愛好家ユーザーID
  body: "家族で農作業、素敵ですね！",
  created_at: Time.new(2024, 8, 16),
  updated_at: Time.new(2024, 8, 16)
)

# りんご一筋（鶴田町）の投稿
farmer5 = User.find_by(email: 'farmer5@email') # りんご一筋
post5 = Post.create!(
  user_id: farmer5.id,
  title: "色付きチェック・糖度チェック",
  body: "今年のりんごは色付きも良好で、糖度も順調に上がっています。もう少しで収穫です。9月25日から道の駅つがるにて直売も開始します！",
  created_at: Time.new(2024, 9, 20)
)
image_path = Rails.root.join("app", "assets", "images", "chokubaijo.jpg")
if File.exist?(image_path)
  post5.image.attach(io: File.open(image_path), filename: "chokubaijo.jpg")
  puts "Image attached to post 5"
end

# コメントを追加
Comment.create!(
  post: post5,
  user_id: fan_users[2].id, # 愛好家ユーザーID
  body: "美味しいりんごが収穫できることを楽しみにしています！今年も大きく育ってください。",
  created_at: Time.new(2024, 9, 21),
  updated_at: Time.new(2024, 9, 21)
)

# アップルパイは弘前で決まり！
post1 = Post.create!(
  user_id: fan_users[0].id,
  title: "アップルパイは弘前で決まり！",
  body: "久々に弘前を訪れました！3軒はしごして食べ比べ🍎してみました。ふじを使ったタイプが美味しかったです〜。",
  created_at: Time.new(2024, 5, 15)
)
# コメントを追加
Comment.create!(
  post: post1,
  user_id: fan_users[4].id, # 愛好家ユーザーID
  body: "ふじのアップルパイ、美味しそう！私も行ってみます〜！",
  created_at: Time.new(2024, 5, 16),
  updated_at: Time.new(2024, 5, 16)
)

# 珍しい品種の食べ比べ会レポ
post2 = Post.create!(
  user_id: fan_users[4].id,
  title: "珍しい品種の食べ比べ会レポ",
  body: "アオモリンゴラボのイベント食べ比べ会に今年も参加してきました！星の金貨・つがる姫・こうとく、どれも個性があって面白い！",
  created_at: Time.new(2024, 9, 30)
)
# コメントを追加
Comment.create!(
  post: post2,
  user_id: farmer2.id, # 農家ユーザーID
  body: "品種ごとの違いを知るのは面白いですね！",
  created_at: Time.new(2024, 10, 1),
  updated_at: Time.new(2024, 10, 1)
)

# 岩木さんとりんご畑を撮る
post3 = Post.create!(
  user_id: fan_users[2].id,
  title: "岩木山とりんご畑",
  body: "このアングルからの岩木山とりんご畑の組み合わせは絶景そのもの。今年も来れて良かった。山の上農園さんにお世話になっています。",
  created_at: Time.new(2024, 10, 20)
)
image_path = Rails.root.join("app", "assets", "images", "mt_iwaki.jpg")
if File.exist?(image_path)
  post3.image.attach(io: File.open(image_path), filename: "mt_iwaki.jpg")
  puts "Image attached to post 3"
end
# コメントを追加
Comment.create!(
  post: post3,
  user_id: fan_users[1].id,
  body: "岩木山素敵ですね。さすが津軽富士。",
  created_at: Time.new(2024, 10, 21),
  updated_at: Time.new(2024, 10, 21)
)
Comment.create!(
  post: post3,
  user_id: farmer3.id, # 農家ユーザーID
  body: "今年もお越しいただきありがとうございました！こうして農家の作業に興味を持っていただき大変感謝しております。",
  created_at: Time.new(2024, 10, 22),
  updated_at: Time.new(2024, 10, 22)
)

# 農業体験で子供も大興奮
post4 = Post.create!(
  user_id: fan_users[3].id,
  title: "農業体験で子供も大興奮",
  body: "石川農園さんにて収穫体験させていただきました。子供も手が土だらけになっても笑顔！一緒にりんごの重さも測りました。",
  created_at: Time.new(2024, 9, 30)
)
# コメントを追加
Comment.create!(
  post: post4,
  user_id: farmer5.id, # 農家ユーザーID
  body: "農業体験、楽しそうですね！子供たちにも農業の楽しさが伝わるはず。",
  created_at: Time.new(2024, 10, 1),
  updated_at: Time.new(2024, 10, 1)
)

# 王林の香りにやられた
post5 = Post.create!(
  user_id: fan_users[1].id,
  title: "王林の香りにやられた",
  body: "他のりんごにはない独特の芳香、ついついリピ買いしちゃいます。アップルパイも作ろうかな。いいレシピがあれば教えて下さい〜",
  created_at: Time.new(2024, 9, 20)
)
# コメントを追加
Comment.create!(
  post: post5,
  user_id: farmer5.id, # 農家ユーザーID
  body: "王林、私も大好きです！香りが本当に魅力的ですよね。",
  created_at: Time.new(2024, 9, 21),
  updated_at: Time.new(2024, 9, 22)
)
Comment.create!(
  post: post5,
  user_id: fan_users[0].id, # 愛好家ユーザーID
  body: "いいレシピありますよ！",
  created_at: Time.new(2024, 9, 21),
  updated_at: Time.new(2024, 9, 22)
)

# 日本の農家って素敵
post6 = Post.create!(
  user_id: fan_users[5].id,
  title: "農家のボランティア",
  body: "リンゴラボの投稿を見て、山の上農園さんにお手伝いに行きました。台湾でもりんごは人気ですがその生産はたくさんの努力があったことを初めて学びました。弘前のりんご農家さんの丁寧な作業あっての美味しいりんごなのだと改めて感じました。",
  created_at: Time.new(2024, 10, 10)
)
# コメントを追加
Comment.create!(
  post: post6,
  user_id: farmer5.id, # 農家ユーザーID
  body: "日本の農家の手作業の丁寧さを素晴らしいと言ってもらえて農家として誇らしいです。勉強頑張って下さいね。",
  created_at: Time.new(2024, 10, 11),
  updated_at: Time.new(2024, 10, 11)
)
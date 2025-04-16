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

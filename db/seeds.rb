# 既存データをクリア（開発環境のみ）
if Rails.env.development?
  puts "Cleaning database..."
  Product.destroy_all
  Genre.destroy_all
end

# ジャンル作成
puts "Creating genres..."
genres = [
  { name: "ケーキ", is_active: true },
  { name: "焼き菓子", is_active: true },
  { name: "プリン", is_active: true },
  { name: "キャンディ", is_active: true }
]

genres.each do |genre_data|
  Genre.find_or_create_by!(name: genre_data[:name]) do |genre|
    genre.is_active = genre_data[:is_active]
  end
end

puts "Created #{Genre.count} genres"

# 商品作成
puts "Creating products..."
products = [
  { name: "イチゴのショートケーキ", introduction: "甘酸っぱいイチゴと生クリームの絶妙なハーモニー", price: 500, is_active: :active, genre: Genre.find_by(name: "ケーキ") },
  { name: "チョコレートケーキ", introduction: "濃厚なチョコレートの味わい", price: 450, is_active: :active, genre: Genre.find_by(name: "ケーキ") },
  { name: "チーズケーキ", introduction: "なめらかな口当たりのチーズケーキ", price: 480, is_active: :active, genre: Genre.find_by(name: "ケーキ") },
  { name: "モンブラン", introduction: "栗の風味豊かなモンブラン", price: 520, is_active: :active, genre: Genre.find_by(name: "ケーキ") },
  { name: "クッキー詰め合わせ", introduction: "サクサクのクッキー10枚入り", price: 300, is_active: :active, genre: Genre.find_by(name: "焼き菓子") },
  { name: "マドレーヌ", introduction: "しっとりふんわりマドレーヌ6個入り", price: 350, is_active: :active, genre: Genre.find_by(name: "焼き菓子") },
  { name: "フィナンシェ", introduction: "アーモンドの香り豊かなフィナンシェ", price: 400, is_active: :active, genre: Genre.find_by(name: "焼き菓子") },
  { name: "なめらかプリン", introduction: "口どけなめらかな極上プリン", price: 250, is_active: :active, genre: Genre.find_by(name: "プリン") },
  { name: "かぼちゃプリン", introduction: "かぼちゃの優しい甘さのプリン", price: 280, is_active: :active, genre: Genre.find_by(name: "プリン") },
  { name: "キャラメルキャンディ", introduction: "濃厚なキャラメル味のキャンディ", price: 200, is_active: :active, genre: Genre.find_by(name: "キャンディ") }
]

products.each do |product_data|
  Product.find_or_create_by!(name: product_data[:name]) do |product|
    product.introduction = product_data[:introduction]
    product.price = product_data[:price]
    product.is_active = product_data[:is_active]
    product.genre = product_data[:genre]
  end
end

puts "Created #{Product.count} products"
puts "Seed data created successfully!"


# 管理者ユーザー作成
puts "Creating admin..."

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
end

puts "Admin created!"


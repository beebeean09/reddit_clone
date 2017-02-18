# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

user = User.new(username: 'admin')
user.password = "password"
user.save!

s = Sub.new(title: 'TestSub', description: 'Test Test Test', user_id: user.id)
s.save!

post = Post.new(title: 'TestPost', sub_id: s.id, user_id: user.id)
post.save!

c1 = (0...100).to_a.map do |i|
  Comment.create(user_id: user.id, content: "#{i}", post_id: post.id)
end

c2 = c1.map do |i|
  (0...100).to_a.map do |j|
    Comment.create(user_id: user.id, content: "#{i.content}, #{j}", post_id: post.id, comment_id: i.id)
  end
end

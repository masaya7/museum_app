10.times do |n|
  User.create!(
    email: "user#{n+1}@example.com",
    password: "password",
    name: "name#{n+1}"
  )
end

User.all.each do |user|
  5.times do |i|
    post = Post.create!(
      user_id: user.id,
      title: "title#{i+1}",
      body: "body#{i+1}",
      image: File.open(Rails.root.join("app/assets/images/image#{i+1}.jpg")),
      status: rand(0..1)
    )

    random_user = User.where.not(id: user.id).sample
    Empathy.create!(
      user_id: random_user.id,
      post_id: post.id,
      empathy: Empathy.empathies.keys.sample
    )
  end
end




User.create!(
  name: 'kinoshita',
  email: 'kino7777777@yahoo.co.jp',
  password: "kinoshita2",
  password_confirmation: "kinoshita2",
  admin: true
)

10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "テスト#{n + 1}",
    password: "testtest#{n + 1}",
    password_confirmation: "testtest#{n + 1}",
    admin: false
  )
end

10.times do |n|
  Task.create!(
    title: "title#{n + 1}",
    content: "content#{n + 1}",
    expired_at: "2023-01-01",
    status: "未着手",
    priority: "高",
    user_id: n + 1
  )
end

10.times do |n|
  Tag.create!(
    name: "ラベル#{n + 1}"
  )
end

10.times do |n|
  Tagging.create!(
    task_id: n + 1,
    tag_id: n + 1
  )
end
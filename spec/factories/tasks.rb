FactoryBot.define do
  factory :task do
    title { 'first_title' }
    content { 'first_content' }
    expired_at { '2023-04-25' }
    status { '着手中' }
    priority { '高' }
    user {}
  end

  factory :task2, class: Task do
    title { 'second_title' }
    content { 'second_content' }
    expired_at { '2023-01-01' }
    status { '未着手' }
    priority { '低' }
    user {}
  end

  factory :task3, class: Task do
    title { 'third_title' }
    content { 'third_content' }
    expired_at { '2023-12-31' }
    status { '着手中' }
    priority { '低' }
    user {}
  end
end
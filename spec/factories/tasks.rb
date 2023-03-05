FactoryBot.define do
  factory :task do
    title { 'first_title' }
    content { 'first_content' }
    expired_at { '2023-04-25' }
    status { '着手中' }
    priority { '高' }
  end

  factory :second_task, class: Task do
    title { 'second_title' }
    content { 'second_content' }
    expired_at { '2023-01-01' }
    status { '未着手' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    title { 'third_title' }
    content { 'third_content' }
    expired_at { '2023-12-31' }
    status { '着手中' }
    priority { '低' }
  end
end
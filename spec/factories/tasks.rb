FactoryBot.define do
  factory :task do
    title { 'task1-1' }
    content { 'task1-2' }
    expired_at { '2023-04-25' }
  end

  factory :second_task, class: Task do
    title { 'task2-1' }
    content { 'task2-2' }
    expired_at { '2023-01-01' }
  end
end
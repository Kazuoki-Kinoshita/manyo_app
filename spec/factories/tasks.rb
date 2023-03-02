FactoryBot.define do
  factory :task do
    title { 'task1-1'}
    content { 'task1-2' }
  end

  factory :second_task, class: Task do
    title { 'task2-1' }
    content { 'task2-2' }
  end
end
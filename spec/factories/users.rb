FactoryBot.define do
  factory :user do
    name { "user1" }
    sequence(:email) { |n| "tester1#{n}@example.com" }
    password { "user1user1" }
    admin { true }
  end
          
  factory :user2, class: User do
    name { "user2" }
    sequence(:email) { |n| "tester2#{n}@example.com" }
    password { "user2user2" }
    admin { false }
  end
end
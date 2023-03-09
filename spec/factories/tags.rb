FactoryBot.define do
  factory :tag do
    name { "ラベル1" }
  end

  factory :tag2, class: Tag do
    name { "ラベル2" }
  end

  factory :tag3, class: Tag do
    name { "ラベル3" }
  end

  factory :tag4, class: Tag do
    name { "ラベル4" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    user { nil }
    post { nil }
  end

  factory :comment do
    text { "MyString" }
    user_id { "MyString" }
    post_id { "MyString" }
  end

  factory :user do
  end

  factory :post do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }

    after :build do |post|
      post.image.attach(io: File.open('spec/pic.jpg'), filename: 'pic.jpg', content_type: 'image/jpg')
    end
  end
end

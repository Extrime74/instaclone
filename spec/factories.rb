# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :user
    association :post
  end

  factory :comment do
    text { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    association :post
    association :user
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end

  factory :post do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    association :user

    after :build do |post|
      post.image.attach(io: File.open('spec/pic.jpg'), filename: 'pic.jpg', content_type: 'image/jpg')
    end
  end
end

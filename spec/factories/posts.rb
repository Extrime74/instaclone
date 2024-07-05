# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    description { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    association :user

    after :build do |post|
      post.image.attach(io: File.open('spec/pic.jpg'), filename: 'pic.jpg', content_type: 'image/jpg')
    end
  end
end

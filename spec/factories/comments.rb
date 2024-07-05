# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.paragraph_by_chars(number: 500, supplemental: false) }
    association :post
    association :user
  end
end

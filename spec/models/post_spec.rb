require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with all required attributes" do
    post = FactoryBot.create(:post)
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = FactoryBot.build(:post, title: nil)
    expect(post).to be_invalid
  end

  it "is invalid with a description longer than 500 characters" do
    post = FactoryBot.build(:post, description: Faker::Lorem.characters(number: 501))
    expect(post).to be_invalid
  end

  it "is invalid without an image" do
    post = Post.new(title: Faker::Lorem.sentence, description: Faker::Lorem.characters(number: 500))
    expect(post).to be_invalid
  end
end
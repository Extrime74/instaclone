# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with all required attributes' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user:)
    comment = FactoryBot.create(:comment)
    expect(comment).to be_valid
  end

  it 'is invalid with text longer than 500 characters' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user:)
    comment = FactoryBot.build(:comment, user:, post:, text: Faker::Lorem.characters(number: 501))
    expect(comment).to be_invalid
  end

  it 'is invalid without text' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user:)
    comment = FactoryBot.build(:comment, user:, post:, text: nil)
    expect(comment).to be_invalid
  end

  it 'is invalid without a user' do
    post = FactoryBot.create(:post)
    comment = FactoryBot.build(:comment, user: nil, post:)
    comment.valid?
    expect(comment.errors[:user]).to include('must exist')
  end

  it 'is invalid without a post' do
    user = FactoryBot.create(:user)
    comment = FactoryBot.build(:comment, user:, post: nil)
    comment.valid?
    expect(comment.errors[:post]).to include('must exist')
  end
end

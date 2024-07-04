# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with all required attributes' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user:)
    like = FactoryBot.create(:like, user:, post:)
    expect(like).to be_valid
  end

  it 'is not valid without a user' do
    post = FactoryBot.create(:post)
    like = FactoryBot.build(:like, user: nil, post:)
    like.valid?
    expect(like.errors[:user]).to include('must exist')
  end

  it 'is not valid without a post' do
    user = FactoryBot.create(:user)
    like = FactoryBot.build(:like, user:, post: nil)
    like.valid?
    expect(like.errors[:post]).to include('must exist')
  end

  it 'validates the uniqueness of user_id scoped to post_id' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    # Создаем первый лайк
    FactoryBot.create(:like, user:, post:)

    # Пытаемся создать второй лайк с тем же пользователем и постом
    second_like = FactoryBot.build(:like, user:, post:)
    second_like.valid?
    expect(second_like.errors[:user_id]).to include('has already been taken')
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { create(:post, user:) }

  before do
    sign_in(user)
  end

  describe 'POST create' do
    it 'should create a like for the post' do
      create(:like, user:, post:)
      expect do
        post posts_path, params: { like: { post_id: post.id } }
      end.to change(Like, :count).by(1)
    end

    it 'should not create a like if the user already liked the post' do
      create(:like, user:, post:)

      expect do
        post likes_path, params: { like: { post_id: post.id } }
      end.to_not change(Like, :count)
    end
  end

  describe 'DELETE destroy' do
    it 'should remove the like' do
      like = create(:like, user:, post:)

      expect do
        delete like_path(like)
      end.to change(Like, :count).by(-1)

      expect(response).to redirect_to(root_path)
    end
  end
end

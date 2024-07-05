# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:valid_attributes) do
    { description: Faker::Lorem.characters(number: 500),
      image: fixture_file_upload(Rails.root.join('spec', 'pic.jpg'), 'image/jpeg'),
      user_id: user.id }
  end
  let!(:invalid_attributes) { { description: Faker::Lorem.characters(number: 501) } }

  before do
    sign_in(user)
  end

  describe 'GET index' do
    it 'should render the index page' do
      get posts_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    let!(:post) { create(:post, user:) }

    it 'should render the show page' do
      get post_path(post)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'should render the new page' do
      get new_post_path
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'should create a new post with valid attributes' do
      expect do
        post posts_path, params: { post: valid_attributes }
      end.to change(Post, :count).by(1)

      expect(response).to redirect_to(Post.last)
    end

    it 'should not create a new post with invalid attributes' do
      expect do
        post posts_path, params: { post: invalid_attributes }
      end.to_not change(Post, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH update' do
    let!(:post) { create(:post, user:) }

    it 'should update the post with valid attributes' do
      patch post_path(post), params: { post: valid_attributes }
      expect(response).to redirect_to(post)
    end

    it 'should not update the post with invalid attributes' do
      patch post_path(post), params: { post: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE destroy' do
    let!(:post) { create(:post, user:) }

    it 'should delete the post' do
      expect do
        delete post_path(post)
      end.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end

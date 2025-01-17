# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post_new) { FactoryBot.create(:post, user:) }
  let!(:valid_attributes) do
    { post_id: post_new.id}
  end

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new like' do
      post likes_path, params: { like: valid_attributes }
      expect do
        response.to be_successful,
                    redirect_to(:back)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:like) { user.likes.create(post: post_new) }

    it 'deletes the like' do
      expect do
        delete :destroy, params: { id: like.id }
      end.to change(Like, :count).by(-1)
      redirect_to(:back)
    end
  end
end

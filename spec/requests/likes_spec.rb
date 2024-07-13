require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a new like' do
      like = create(:like, post:, user:)
      expect{
        (response).to be_successful, 
        redirect_to(:back)
      }
    end
  end

  describe 'DELETE #destroy' do
    let!(:like) { user.likes.create(post: post) }

    it 'deletes the like' do
      expect {
        delete :destroy, params: { id: like.id }
      }.to change(Like, :count).by(-1)
      redirect_to(:back)
    end
  end
end
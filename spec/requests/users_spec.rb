# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user)
  end

  describe 'GET index' do
    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #follow' do
    it 'отправляет запрос на подписку пользователю' do
      sign_in user
      another_user = create(:user)
      post :follow, params: { id: another_user.id }
      expect(user.pending_follow_requests_sent_to?(another_user)).to be_truthy
    end
  end
end

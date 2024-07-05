# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET /show' do
    let(:user) { create(:user) }

    it 'returns http success' do
      get "/users/#{user.id}"
      follow_redirect! # Follow the redirect caused by authentication
      expect(response).to have_http_status(:success)
    end
  end
end

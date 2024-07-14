# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/comments', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user:) }
  let!(:valid_attributes) do
    { text: Faker::Lorem.characters(number: 250),
      post:,
      user: }
  end
  let(:comment) { Comment.create! valid_attributes }

  let!(:invalid_attributes) { { text: Faker::Lorem.characters(number: 501) } }

  before do
    sign_in(user)
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Comment' do
        expect do
          create(:comment, post:, user:)
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the created comment' do
        Comment.create! valid_attributes
        expect redirect_to(post_path(post))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Comment' do
        comment = build(:comment, text: Faker::Lorem.characters(number: 501))
        expect(comment).to_not be_valid
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested comment' do
      comment = Comment.create! valid_attributes
      expect do
        delete comment_url(comment)
      end.to change(Comment, :count).by(-1)
    end

    it 'redirects to the comments list' do
      comment = Comment.create! valid_attributes
      delete comment_url(comment)
      expect(response).to redirect_to(post_path(post))
    end
  end
end

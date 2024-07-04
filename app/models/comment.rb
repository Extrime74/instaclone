# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :text, length: { maximum: 500 }, presence: true

  belongs_to :post
  belongs_to :user
end

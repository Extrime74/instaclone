# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 500 }
  validates :image, presence: true
  has_one_attached :image

  belongs_to :user
end

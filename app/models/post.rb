# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, length: { maximum: 500 }
  validates :image, presence: true
  belongs_to :user

  has_one_attached :image
  has_many :comments
  has_many :likes, dependent: :destroy
end
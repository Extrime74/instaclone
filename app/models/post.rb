class Post < ApplicationRecord

    validates :title, presence:true 
    validates :description, length: {maximum:500}
    has_one_attached :image
    validates_presence_of :image
end

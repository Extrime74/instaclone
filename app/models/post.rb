class Post < ApplicationRecord

    validates :title, presence:true 
    validates :description, length: {maximum:500}
end

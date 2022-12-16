class Comment < ApplicationRecord
  belongs_to :product

  validates :body, presence: true, length: {minimum: 4}
  
  
end

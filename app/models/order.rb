class Order < ApplicationRecord
  belongs_to :user

  has_many :carts
  has_many :products, through: :carts

  validates :address, presence: true
  validates :contact, presence: true, length: { minimum: 11, maximum: 11 }


  

end

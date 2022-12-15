class Order < ApplicationRecord
  belongs_to :user

  has_many :carts
  has_many :products, through: :carts

  validates :address, presence: true
  validates :contact, presence: true, length: { maximum: 11, minimum: 11 }


  

end

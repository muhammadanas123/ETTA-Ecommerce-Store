class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify
  has_many :products, through: :roles, source: :resource, source_type:  :Product
  has_many :created_products, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type:  :Product
end

class Product < ApplicationRecord
    resourcify
    has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
    has_many :creators, -> { where(:roles => {name: :creator}) }, through: :roles, class_name: 'User', source: :users
end

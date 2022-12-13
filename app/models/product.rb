class Product < ApplicationRecord
    resourcify
    has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
    has_many :creators, -> { where(:roles => {name: :creator}) }, through: :roles, class_name: 'User', source: :users
    has_many :buyers, -> { where(:roles => {name: :buyer}) }, through: :roles, class_name: 'User', source: :users

    has_many :carts, dependent: :destroy
    has_many :orders, through: :carts, dependent: :destroy
    validate :id_exist?


    private

    def id_exist?
        if !id.present?
            errors.add("id field is empty")
        end

    end
end

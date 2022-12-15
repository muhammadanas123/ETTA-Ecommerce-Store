class Product < ApplicationRecord
    resourcify
    has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
    has_many :creators, -> { where(:roles => {name: :creator}) }, through: :roles, class_name: 'User', source: :users
    has_many :buyers, -> { where(:roles => {name: :buyer}) }, through: :roles, class_name: 'User', source: :users

    has_many :carts, dependent: :destroy
    has_many :orders, through: :carts, dependent: :destroy

    validates :product_name, :product_desc, presence: true, length: { minimum: 7 }
    validates :price, presence: true
    # validate :id_exist?

    enum category: { electronics: 0, appliance: 1, clothing: 2 }


    def self.search_with_category(search)
        where(category: search)

    end

    def self.search(param)
        # byebug
        param.strip!
        to_send_back = (product_name_matches(param) + product_desc_matches(param) + brand_matches(param)).uniq
        return nil unless to_send_back
        to_send_back
    end

    def self.product_name_matches(param)
        matches('product_name',param)
    end

    def self.product_desc_matches(param)
        matches('product_desc',param)
    end

    def self.brand_matches(param)
        matches('brand',param)
    end

    def self.matches(field_name, param)
        where("#{field_name} like ?", "%#{param}%")
    end

    # private

    # def id_exist?
    #     if !id.present?
    #         errors.add("id field is empty")
    #     end

    # end
end

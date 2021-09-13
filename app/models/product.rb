class Product < ApplicationRecord
  belong_to :user
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :product_description
    validates :category_id
    validates :product_condition_id
    validates :shipping_charge_id
    validates :shipping_area_id
    validates :shipping_ship_id
    validates :price
    validates :image
  end

end

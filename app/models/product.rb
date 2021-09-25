class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :product_condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :shipping_ship
  has_one    :purchase_record

  with_options presence: true do
    validates :title, :product_description, :image

    with_options numericality: { other_than: 1 } do
      validates :category_id, :product_condition_id, :shipping_charge_id, :shipping_area_id, :shipping_ship_id
    end

    with_options format: { with: /\A[0-9]+\z/ } do
      validates :price, numericality: { greater_than: 299, less_than: 10_000_000 }
    end
  end
end

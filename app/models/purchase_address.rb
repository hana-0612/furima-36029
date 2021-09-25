class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number,
                :purchase_record_id, :token

  with_options presence: true do
    validates :city, :house_number, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :telephone_number, presence: true, format: { with: /\A[0-9]{10,11}\z/ }
  end

  def save
    PurchaseRecord.create(product_id: product_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, telephone_number: telephone_number, purchase_record_id: purchase_record_id)
  end
end

FactoryBot.define do
  factory :product do
    title                { Faker::Name.initials }
    product_description  { Faker::Lorem.sentence }
    association :user 
    category_id          { Faker::Number.between(from: 2, to: 11) }
    product_condition_id { Faker::Number.between(from: 2, to: 7) }
    shipping_charge_id   { Faker::Number.between(from: 2, to: 3) }
    shipping_area_id     { Faker::Number.between(from: 2, to: 48) }
    shipping_ship_id     { Faker::Number.between(from: 2, to: 4) }
    price                { Faker::Number.between(from: 300, to: 9999999) }
  
    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')
    end

  end
end

FactoryBot.define do
  factory :purchase_address do
    postal_code      { '123-4567' }
    prefecture_id    { Faker::Number.between(from: 2, to: 48) }
    city             { '東京都' }
    house_number     { '1-1' }
    building_name    { '柳ビル' }
    telephone_number { '09000000000' }
    token            { 'tok_abcdefghijk00000000000000000' }
  end
end

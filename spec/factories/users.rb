FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '隆太郎' }
    kana_last_name        { 'ヤマダ' }
    kana_first_name       { 'リクタロウ' }
    date_of_birth         { Faker::Date.backward }
  end
end

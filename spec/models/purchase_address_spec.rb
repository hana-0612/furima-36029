require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入内容の保存' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入ができること' do
        expect(@purchase_address).to be_valid
      end
      it '建物名は空でも保存できること' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(postal_code: ["can't be blank", 'is invalid'])
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.postal_code = '1112345'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(postal_code: ['is invalid'])
      end
      it '都道府県を選択していないと保存できないこと' do
        @purchase_address.prefecture_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(prefecture_id: ["can't be blank", 'is not a number'])
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(city: ["can't be blank"])
      end
      it '番地が空だと保存できないこと' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(house_number: ["can't be blank"])
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_address.telephone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: ["can't be blank", 'is invalid'])
      end
      it '電話番号が半角数字10桁以上11桁以内でないと保存できないこと' do
        @purchase_address.telephone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: ['is invalid'])
      end
    end
  end
end

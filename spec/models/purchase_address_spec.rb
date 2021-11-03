require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入内容の保存' do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, product_id: product.id)
      sleep 0.1
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
        expect(@purchase_address.errors.full_messages).to include('トークンを入力してください')
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(postal_code: %w[を入力してください は不正な値です])
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.postal_code = '1112345'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(postal_code: ['は不正な値です'])
      end
      it '都道府県で1を選択すると保存できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(prefecture_id: ['は1以外の値にしてください'])
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(city: ['を入力してください'])
      end
      it '番地が空だと保存できないこと' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(house_number: ['を入力してください'])
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_address.telephone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: %w[を入力してください は不正な値です])
      end
      it '電話番号が半角数字9桁以下は保存できないこと' do
        @purchase_address.telephone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: ['は不正な値です'])
      end
      it '電話番号が半角数12桁以上は保存できないこと' do
        @purchase_address.telephone_number = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: ['は不正な値です'])
      end
      it '電話番号が半角数字以外が含まれている場合は保存できないこと' do
        @purchase_address.telephone_number = '1234５５５５５５'
        @purchase_address.valid?
        expect(@purchase_address.errors.messages).to include(telephone_number: ['は不正な値です'])
      end
      it '商品が紐付いていないと保存できないこと' do
        @purchase_address.product_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('商品を入力してください')
      end
      it 'お名前が紐付いていないと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('お名前を入力してください')
      end
    end
  end
end

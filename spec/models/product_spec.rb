require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '出品登録' do
    context '出品登録がうまくいくとき' do
      it '全ての項目が正しく入力されてあれば登録できる' do
        expect(@product).to be_valid
      end
      it 'ログイン状態のユーザーのみ、商品出品ページへ遷移できること' do
        @product = FactoryBot.create(:user)
        expect(@product).to be_valid
      end
    end  

    context '出品登録がうまくいかないとき' do
      it 'imageが空では登録されない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録できない' do
        @product.title = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Title can't be blank")
      end

      it '商品の説明が空では登録できない' do
        @product.product_description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Product description can't be blank")
      end

      it 'カテゴリーが空では登録できない' do
        @product.category_id= nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が空では登録できない' do
        @product.product_condition_id= nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Product condition can't be blank"
      end

      it '配送料の負担が空では登録できない' do
        @product.shipping_charge_id= nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping charge can't be blank"
      end

      it '配送元の地域が空では登録できない' do
        @product.shipping_area_id= nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping area can't be blank"
      end

      it '発送までの日数が空では登録できない' do
        @product.shipping_ship_id= nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping ship can't be blank"
      end

      it '販売価格が空では登録できない' do
        @product.price= ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end

      it 'プルダウンが"---"では登録できない' do
        @product.category_id = '1'
        @product.product_condition_id = '1'
        @product.shipping_charge_id = '1' 
        @product.shipping_area_id = '1'
        @product.shipping_ship_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include("Category must be other than 1", "Product condition must be other than 1", "Shipping charge must be other than 1", "Shipping area must be other than 1", "Shipping ship must be other than 1")
      end

      it '販売価格が英字のみでは登録できない' do
        @product.price = 'aaaaaa'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end

      it '販売価格に全角文字があると登録できない' do
        @product.price = 'あああ'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end

      it '販売価格が300以下であると登録できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be greater than 300'
      end

      it '販売価格が9999999以上であると登録できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be less than 9999999'
      end
    end
  end
end

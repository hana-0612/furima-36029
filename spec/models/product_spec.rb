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
    end

    context '出品登録がうまくいかないとき' do
      it 'imageが空では登録されない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('商品画像を入力してください')
      end

      it '商品名が空では登録できない' do
        @product.title = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('商品名を入力してください')
      end

      it '商品の説明が空では登録できない' do
        @product.product_description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('商品の説明を入力してください')
      end

      it 'カテゴリーが空では登録できない' do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include 'カテゴリーを入力してください'
      end

      it '商品の状態が空では登録できない' do
        @product.product_condition_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include '商品の状態を入力してください'
      end

      it '配送料の負担が空では登録できない' do
        @product.shipping_charge_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include '配達費の負担を入力してください'
      end

      it '発送元の地域が空では登録できない' do
        @product.shipping_area_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include '発送元の地域を入力してください'
      end

      it '発送までの日数が空では登録できない' do
        @product.shipping_ship_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include '発送までの日数を入力してください'
      end

      it '販売価格が空では登録できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include '価格を入力してください'
      end

      it 'カテゴリーのプルダウンが"---"では登録できない' do
        @product.category_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include 'カテゴリーは1以外の値にしてください'
      end

      it '商品の状態が"---"では登録できない' do
        @product.product_condition_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include '商品の状態は1以外の値にしてください'
      end

      it '配送料の負担が"---"では登録できない' do
        @product.shipping_charge_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include '配達費の負担は1以外の値にしてください'
      end

      it '発送元の地域が"---"では登録できない' do
        @product.shipping_area_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include '発送元の地域は1以外の値にしてください'
      end

      it '発送までの日数が"---"では登録できない' do
        @product.shipping_ship_id = '1'
        @product.valid?
        expect(@product.errors.full_messages).to include '発送までの日数は1以外の値にしてください'
      end

      it '販売価格が英字のみでは登録できない' do
        @product.price = 'aaaaaa'
        @product.valid?
        expect(@product.errors.full_messages).to include '価格は数値で入力してください'
      end

      it '販売価格に全角文字があると登録できない' do
        @product.price = 'あああ'
        @product.valid?
        expect(@product.errors.full_messages).to include '価格は数値で入力してください'
      end

      it '販売価格が300以下であると登録できない' do
        @product.price = '299'
        @product.valid?
        expect(@product.errors.full_messages).to include '価格は299より大きい値にしてください'
      end

      it '販売価格が9999999以上であると登録できない' do
        @product.price = '10000000'
        @product.valid?
        expect(@product.errors.full_messages).to include '価格は10000000より小さい値にしてください'
      end
    end
  end
end

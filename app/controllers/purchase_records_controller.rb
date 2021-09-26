class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :product_find

  def index
    if current_user.id != @product.user_id && @product.purchase_record.nil?
      @purchase_address = PurchaseAddress.new
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_record_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def product_find
    @product = Product.find(params[:product_id])
  end

  def purchase_record_params
    params.require(:purchase_address).permit(
      :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number
    ).merge(
      token: params[:token], product_id: params[:product_id], user_id: current_user.id
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end
end

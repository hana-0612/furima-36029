class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    #@products = Product.all.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.valid?
      @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :product_description, :category_id, :product_condition_id, :shipping_charge_id,
                                    :shipping_area_id, :shipping_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end

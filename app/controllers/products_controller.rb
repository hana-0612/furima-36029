class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :product_find, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order('created_at DESC')
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

  def show
  end

  def edit
    redirect_to products_path unless current_user.id == @product.user_id
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path(@product.id)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :product_description, :category_id, :product_condition_id, :shipping_charge_id,
                                    :shipping_area_id, :shipping_ship_id, :price, :image).merge(user_id: current_user.id)
  end

  def product_find
    @product = Product.find(params[:id])
  end
end

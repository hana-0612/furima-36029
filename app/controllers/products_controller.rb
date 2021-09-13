class ProductsController < ApplicationController
  def index
  end

  private
  def product_params
    parrams.require(:product).permit(:title, :product_description, :category_id, :product_condition_id, :shipping_charge_id, :shipping_area_id, :shipping_ship_id, :price :image).merge(user_id: current_user.id)
  end
end

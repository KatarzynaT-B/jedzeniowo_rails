class ProductsController < ApplicationController
  before_action :signed_in_user

  def index
    @products = @current_user.products.paginate(page: params[:page], per_page: 5)
    if @products.empty?
      render 'new'
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_calories, :product_protein, :product_fat, :product_carbs)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end

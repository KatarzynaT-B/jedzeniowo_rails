class ProductsController < ApplicationController
  include ProductsHelper
  before_action :signed_in_user

  def index
    @products = @current_user.products.paginate(page: params[:page], per_page: 5)
    if @products.empty?
      redirect_to new_product_path
    end
  end

  def new
    @product = @current_user.products.build
  end

  def create
    @product = @current_user.products.build(product_params)
    if @product.save
      @product.count_calories
      redirect_to products_path
      flash[:success] = "Produkt został dodany"
    else
      render action: 'new'
    end
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

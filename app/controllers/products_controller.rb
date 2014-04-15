class ProductsController < ApplicationController
  before_action :signed_in_user
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = @current_user.products.paginate(page: params[:page], per_page: 5)
    @product = @current_user.products.build
    if @products.empty?
      flash[:notice] = (t 'flash.shared.index.notice', target: "produktów")
    end
  end

  def create
    @product = @current_user.products.build(product_params)
    redirect_to products_path
    flash[:success] = (t 'flash.shared.create.success', target: "produkt") if @product.save
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
      flash[:success] = (t 'flash.shared.update.success', target: "produkt")
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = (t 'flash.shared.destroy.success', target: "produkt")
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :product_protein, :product_fat, :product_carbs)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end

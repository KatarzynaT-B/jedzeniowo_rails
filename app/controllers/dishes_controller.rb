class DishesController < ApplicationController
  before_action :signed_in_user
  before_action :set_products, except: :destroy
  before_action :set_dish, only: [:edit, :destroy]
  before_action :set_dish_with_ingredients, only: [:show, :update]

  def index
    @dishes = @current_user.dishes.paginate(page: params[:page], per_page: 5)
    @dish = @current_user.dishes.build
    @dish.ingredients.build
    if @dishes.empty?
      flash[:notice] = (t 'flash.shared.index.notice', target: "stworzonych dań")
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @dish = @current_user.dishes.build(dish_params)
    redirect_to dishes_path
    flash[:success] = (t 'flash.shared.create.success', target: "danie") if @dish.save
  end

  def update
    if @dish.update(dish_params)
      redirect_to @dish
      flash[:success] = (t 'flash.shared.update.success', target: "danie")
    else
      render action: 'edit'
    end
  end

  def destroy
    @dish.destroy
    flash[:success] = (t 'flash.shared.destroy.success', target: "danie")
    redirect_to dishes_url
  end

  private

    def dish_params
      params.require(:dish).permit(:dish_name, :dish_steps, :dish_protein, :dish_fat, :dish_carbs, :dish_calories,
                                   ingredients_attributes: [:id, :quantity_per_dish, :product_id, :dish_id, :_destroy])
    end

    def set_products
      @products = @current_user.products
    end

    def set_dish
      @dish = @current_user.dishes.find(params[:id])
    end

    def set_dish_with_ingredients
      @dish = @current_user.dishes.includes(ingredients: :product).find(params[:id])
    end


end

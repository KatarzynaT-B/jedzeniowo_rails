class DishesController < ApplicationController
  before_action :signed_in_user
  before_action :set_products, except: :destroy
  before_action :set_dish, only: [:edit, :destroy]
  before_action :set_dish_with_ingredients, only: [:show, :update]

  def index
    @dishes = @current_user.dishes.paginate(page: params[:page], per_page: 5)
    redirect_to new_dish_path if @dishes.empty?
  end

  def show
  end

  def new
    @dish = @current_user.dishes.build
    @dish.ingredients.build
  end

  def edit
  end

  def create
    @dish = @current_user.dishes.build(dish_params)
    if @dish.save
      redirect_to @dish
      flash[:success] = t 'flash.dishes.create.success'
    else
      render action: 'new'
    end
  end

  def update
    if @dish.update(dish_params)
      redirect_to @dish
      flash[:success] = t 'flash.dishes.update.success'
    else
      render action: 'edit'
    end
  end

  def destroy
    @dish.destroy
    flash[:success] = t 'flash.dishes.destroy.success'
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

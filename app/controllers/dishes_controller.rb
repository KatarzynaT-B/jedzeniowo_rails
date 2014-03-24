class DishesController < ApplicationController
  before_action :signed_in_user

  def index
    @dishes = @current_user.dishes.paginate(page: params[:page], per_page: 5)
    if @dishes.empty?
      redirect_to new_dish_path
    end
  end

  def show
    @dish = @current_user.dishes.find(params[:id])
  end

  def new
    @products = @current_user.products
    @dish = @current_user.dishes.build
    @dish.ingredients.build
  end

  def edit
  end

  def create
    @products = @current_user.products
    @dish = @current_user.dishes.create(dish_params)
    if @dish.save
      redirect_to @dish
      flash[:notice] = "Danie zostało zapisane"
    else
      render action: 'new'
    end
  end

  def update
  end

  def destroy
  end

  def dish_params
    params.require(:dish).permit(:dish_name, :dish_steps, :dish_protein, :dish_fat, :dish_carbs, :dish_calories,
                                 ingredients_attributes: [:id, :quantity_per_dish, :product_id, :dish_id, :_destroy])
  end

end

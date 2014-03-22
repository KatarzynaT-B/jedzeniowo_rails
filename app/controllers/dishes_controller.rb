class DishesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @dish = Dish.new
    @dish.ingredients.build
  end

  def edit
  end

  def create
    @dish = Dish.create(dish_params)
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
                                 ingredients_attributes: [:id, :quantity_per_dish, :product_id, :dish_id])
  end

end

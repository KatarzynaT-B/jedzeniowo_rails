class MenusController < ApplicationController
  before_action :signed_in_user
  before_action :set_menu, only: [:edit, :destroy]
  before_action :set_menu_with_meals, only: [:show, :update]
  before_action :set_meal_types, except: :destroy
  before_action :set_dishes, only: [:edit, :new]
  before_action :set_dishes_with_ingredients, except: [:new, :edit, :destroy]

  def index
    @menus = @current_user.menus.paginate(page: params[:page], per_page: 5)
    @menu = @current_user.menus.build
    @menu.meals.build
    redirect_to new_menu_path if @menus.empty?
  end

  def show
  end

  def new
    @menu = @current_user.menus.build
    @menu.meals.build
  end

  def create
    @menu = @current_user.menus.create(menu_params)
    if @menu.save
      redirect_to @menu
      flash[:success] = (t 'flash.shared.create.success', target: "jadłospis")
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      redirect_to @menu
      flash[:success] = (t 'flash.shared.update.success', target: "jadłospis")
    else
      render action: 'edit'
    end
  end

  def destroy
    @menu.destroy
    flash[:success] = (t 'flash.shared.destroy.success', target: "jadłospis")
    redirect_to menus_url
  end

  private

    def menu_params
      params.require(:menu).permit(:menu_date, :meals_no, :menu_calories, :menu_protein, :menu_fat, :menu_carbs,
                                   meals_attributes: [:id, :dish_id, :meal_type_id, :menu_id, :_destroy])
    end

    def set_menu
      @menu = @current_user.menus.find(params[:id])
    end

    def set_menu_with_meals
      @menu = @current_user.menus.includes(meals: [{dish: [ingredients: :product]}, :meal_type]).find(params[:id])
    end

    def set_meal_types
      @meal_types = @current_user.meal_types
    end

    def set_dishes
      @dishes = @current_user.dishes
    end

    def set_dishes_with_ingredients
      @dishes = @current_user.dishes.includes(ingredients: :product)
    end
end

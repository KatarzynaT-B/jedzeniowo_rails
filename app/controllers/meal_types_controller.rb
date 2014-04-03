class MealTypesController < ApplicationController
  before_action :signed_in_user
  before_action :set_meal_type, only: [:edit, :update, :destroy]

  def index
    @meal_types = @current_user.meal_types
    if @meal_types.empty?
      redirect_to new_meal_type_path
    end
  end

  def new
    @meal_type = @current_user.meal_types.build
  end

  def create
    @meal_type = @current_user.meal_types.build(meal_type_params)
    if @meal_type.save
      redirect_to meal_types_path
      flash[:success] = t 'flash.shared.create.success', target: "typ posiłku"
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @meal_type.update(meal_type_params)
      redirect_to meal_types_path
      flash[:success] = t 'flash.shared.update.success', target: "typ posiłku"
    else
      render action: 'edit'
    end
  end

  def destroy
    @meal_type.destroy
    flash[:success] = t 'flash.shared.destroy.success', target: "typ posiłku"
    redirect_to meal_types_path
  end

  private

    def meal_type_params
      params.require(:meal_type).permit(:name)
    end

    def set_meal_type
      @meal_type = @current_user.meal_types.find(params[:id])
    end

end

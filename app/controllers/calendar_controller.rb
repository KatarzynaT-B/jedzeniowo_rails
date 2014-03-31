class CalendarController < ApplicationController
  include DateAndTime
  include CalendarsHelper
  include DateAndTime::Calculations
  before_action :signed_in_user
  #before_action :set_meal_types, :set_dishes, :set_products

  def day
    @date = (params[:date] ? Date.strptime(params[:date], "%Y-%m-%d") : Date.strptime(Time.now.strftime("%Y-%m-%d")))
    @menu = Menu.includes(meals: [{dish: [ingredients: :product]}, :meal_type]).find_by(menu_date: @date, user: @current_user)
    @meals = @menu.meals.includes(:dishes) if @menu
  end

  def month
    @date = (params[:month] ? Date.strptime(params[:month] + '-01', "%Y-%m-%d") : Date.strptime(Time.now.strftime("%Y-%m-%d")))
    @weeks = build_weeks(@date)
  end

  def build_weeks(date)

end

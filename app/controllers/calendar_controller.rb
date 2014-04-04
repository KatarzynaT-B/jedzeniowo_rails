class CalendarController < ApplicationController
  require 'calendar_month.rb'

  before_action :signed_in_user
  #before_action :set_meal_types, :set_dishes, :set_products

  #def day
  #  @date = (params[:date] ? Date.strptime(params[:date], format: 'date.formats.custom') : Date.strptime(Time.now ))
  #  @menu = Menu.includes(meals: [{dish: [ingredients: :product]}, :meal_type]).find_by(menu_date: @date, user: @current_user)
  #  @meals = @menu.meals.includes(:dishes) if @menu
  #end

  def month
    @date = (params[:year_month] ? params[:year_month] : Time.now)
    @cal = CalendarMonth.new(@date)
  end
end

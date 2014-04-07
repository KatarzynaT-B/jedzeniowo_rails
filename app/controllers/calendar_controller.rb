class CalendarController < ApplicationController
  require 'calendar_month.rb'
  include DateAndTime::Calculations
  include DateAndTime
  include CalendarHelper

  before_action :signed_in_user

  def day
    @date = (params[:date] ? Date.parse(params[:date]) : Date.today )
    @menu = Menu.includes(
        meals: [{dish: [ingredients: :product]},
        :meal_type]
        ).find_by(menu_date: @date, user: @current_user)
    @meals = @menu.meals.includes(:dishes) if @menu
  end

  def month
    @date = (params[:year_month] ? Date.parse(params[:year_month]) : Date.today)
    @calendar = CalendarMonth.new(@date)
    @menus = Menu.includes(
        meals: [:dish, :meal_type]
        ).where(user_id: @current_user.id)
  end
end
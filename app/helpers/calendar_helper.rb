module CalendarHelper
  def meals_for_day_in_month(day)
    menu = Menu.includes(meals: [:dish, :meal_type]).find_by(menu_date: day, user: @current_user)
    if menu
      menu.meals.inject([]) { |meals_set, meal| meals_set << "#{ meal.meal_type.name } - #{ meal.dish.dish_name } "}
    else
      ['brak jadłospisu']
    end
  end
end

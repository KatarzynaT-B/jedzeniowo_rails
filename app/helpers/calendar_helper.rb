module CalendarHelper
  def meals_for_day_in_month(day)
    menu = @menus.find { |menu| menu.menu_date == day }
    if menu
      menu.meals.inject([]) do |meals_set, meal|
        meals_set << "#{ meal.meal_type.name } - #{ meal.dish.dish_name } "
      end
    else
      ['brak jadłospisu']
    end
  end
end

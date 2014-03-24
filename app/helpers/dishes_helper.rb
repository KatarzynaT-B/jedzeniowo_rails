module DishesHelper

  def count_calories(dish)
    calories = 0
    dish.ingredients.each { |i| calories += i.count_calories }
    "#{calories.round} kcal"
  end

  def count_protein(dish)
    protein = 0
    dish.ingredients.each { |i| protein += i.count_protein }
    "#{(4.0 * protein).round} kcal (#{protein.round(2)} g)"
  end

  def count_fat(dish)
    fat = 0
    dish.ingredients.each { |i| fat += i.count_fat }
    "#{(9.0 * fat).round} kcal (#{fat.round(2)} g)"
  end

  def count_carbs(dish)
    carbs = 0
    dish.ingredients.each { |i| carbs += i.count_carbs }
    "#{(4.0 * carbs).round} kcal (#{carbs.round(2)} g)"
  end
end

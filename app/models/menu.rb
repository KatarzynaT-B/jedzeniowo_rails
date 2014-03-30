class Menu < ActiveRecord::Base
  before_save :count_meals, :count_calories, :count_carbs, :count_fat, :count_protein

  belongs_to :user
  has_many :dishes, through: :meals
  has_many :meal_types, through: :meals
  has_many :meals, dependent: :destroy

  accepts_nested_attributes_for :meals, allow_destroy: true

  validates :user, presence: true

  def count_meals
    self.meals_no = self.meals.count
  end

  def count_calories
    calories = 0
    self.meals.each { |meal| calories += meal.dish.dish_calories }
    self.menu_calories = calories.round
  end

  def count_protein
    protein = 0
    self.meals.each { |meal| protein += meal.dish.dish_protein }
    self.menu_protein = protein.round(2)
  end

  def count_fat
    fat = 0
    self.meals.each { |meal| fat += meal.dish.dish_fat }
    self.menu_fat = fat.round(2)
  end

  def count_carbs
    carbs = 0
    self.meals.each { |meal| carbs += meal.dish.dish_carbs }
    self.menu_carbs = carbs.round(2)
  end
end

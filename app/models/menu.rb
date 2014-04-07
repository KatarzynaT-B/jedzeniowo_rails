class Menu < ActiveRecord::Base
  before_save :count_calories, :count_carbs, :count_fat, :count_protein

  belongs_to :user
  has_many :dishes, through: :meals
  has_many :meal_types, through: :meals
  has_many :meals, dependent: :destroy

  accepts_nested_attributes_for :meals, allow_destroy: true

  validates :user, presence: true

  def count_calories
    self.menu_calories = (meals.includes(:dish).inject(0) { |calories, meal| calories + meal.dish.dish_calories }).round
  end

  def count_protein
    self.menu_protein = (meals.includes(:dish).inject(0) { |protein, meal| protein + meal.dish.dish_protein }).round(2)
  end

  def count_fat
    self.menu_fat = (meals.includes(:dish).inject(0) { |fat, meal| fat + meal.dish.dish_fat }).round(2)
  end

  def count_carbs
    self.menu_carbs = (meals.includes(:dish).inject(0) { |carbs, meal| carbs + meal.dish.dish_carbs }).round(2)
  end
end

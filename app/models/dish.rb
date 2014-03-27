class Dish < ActiveRecord::Base
  before_save :count_calories, :count_carbs, :count_fat, :count_protein

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :user,      presence:   true
  validates :dish_name, presence:   { message: "Podaj nazwę dania" },
                        uniqueness: { message: "Danie o takiej nazwie już istnieje" }

  def count_calories
    calories = 0
    self.ingredients.includes(:product).each { |i| calories += i.count_calories }
    self.dish_calories = calories.round
  end

  def count_protein
    protein = 0
    self.ingredients.each { |i| protein += i.count_protein }
    self.dish_protein = protein.round(2)
  end

  def count_fat
    fat = 0
    self.ingredients.each { |i| fat += i.count_fat }
    self.dish_fat = fat.round(2)
  end

  def count_carbs
    carbs = 0
    self.ingredients.each { |i| carbs += i.count_carbs }
    self.dish_carbs = carbs.round(2)
  end
end

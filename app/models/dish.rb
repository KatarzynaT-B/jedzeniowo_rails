class Dish < ActiveRecord::Base
  before_save :count_calories, :count_carbs, :count_fat, :count_protein

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :user,      presence:   true
  validates :dish_name, presence:   true,
                        uniqueness: true

  def count_calories
    self.dish_calories = (ingredients.inject(0) { |kcal, ingredient| kcal + ingredient.count_calories }).round
  end

  def count_protein
    self.dish_protein = (ingredients.inject(0) { |protein, ingredient| protein + ingredient.count_protein }).round(2)
  end

  def count_fat
    self.dish_fat = (ingredients.inject(0) { |fat, ingredient| fat + ingredient.count_fat }).round(2)
  end

  def count_carbs
    self.dish_carbs = (ingredients.inject(0) { |carbs, ingredient| carbs + ingredient.count_carbs }).round(2)
  end
end

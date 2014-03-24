class Ingredient < ActiveRecord::Base
  belongs_to :dish
  belongs_to :product

  validates :product,           presence: true
  validates :quantity_per_dish, presence: { message: "Podaj ilość składnika potrzebną do przygotowania dania" },
                                numericality: {message: "Ilość składnika podana niepoprawnie" }

  def count_calories
    self.quantity_per_dish * self.product.product_calories / 100
  end

  def count_protein
    self.quantity_per_dish * self.product.product_protein / 100
  end

  def count_fat
    self.quantity_per_dish * self.product.product_fat / 100
  end

  def count_carbs
    self.quantity_per_dish * self.product.product_carbs / 100
  end

end

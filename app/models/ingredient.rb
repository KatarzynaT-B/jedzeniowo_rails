class Ingredient < ActiveRecord::Base
  belongs_to :dish
  belongs_to :product

  validates :product,           presence: true
  validates :quantity_per_dish, presence: { message: "Podaj ilość składnika potrzebną do przygotowania dania" },
                                numericality: {message: "Ilość składnika podana niepoprawnie" }

end

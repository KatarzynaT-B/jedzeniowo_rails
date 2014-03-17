class Product < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('product_name ASC') }

  validates :user,            presence: true

  validates :product_name,    presence:     { message: "Podaj nazwę produktu" },
                              uniqueness:   { message: "Produkt o takiej nazwie już istnieje" }

  validates :product_protein, presence:     { message: "Podaj ilość białka" },
                              numericality: { message: "Ilość białka podana niepoprawnie" }

  validates :product_fat,     presence:     { message: "Podaj ilość tłuszczu" },
                              numericality: { message: "Ilość tłuszczu podana niepoprawnie" }

  validates :product_carbs,   presence:     { message: "Podaj ilość węglowodanów" },
                              numericality: { message: "Ilość węglowodanów podana niepoprawnie" }

  def protein_kcal
    (4 * self.product_protein.to_f).round
  end

  def fat_kcal
    (9 * self.product_fat.to_f).round
  end

  def carbs_kcal
    (4 * self.product_carbs.to_f).round
  end

  def count_calories
    (self.product_calories = self.protein_kcal + self.fat_kcal + self.carbs_kcal).to_i
  end
end

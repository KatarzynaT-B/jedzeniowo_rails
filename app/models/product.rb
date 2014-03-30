class Product < ActiveRecord::Base
  before_save :count_calories

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  default_scope -> { order('product_name ASC') }

  validates :user,            presence: true
  validates :product_name,    presence:     { message: "Podaj nazwę produktu" },
                              uniqueness:   { scope: :user_id, message: "Produkt o takiej nazwie już istnieje" }
  validates :product_protein, presence:     { message: "Podaj ilość białka" },
                              numericality: { message: "Ilość białka podana niepoprawnie" }
  validates :product_fat,     presence:     { message: "Podaj ilość tłuszczu" },
                              numericality: { message: "Ilość tłuszczu podana niepoprawnie" }
  validates :product_carbs,   presence:     { message: "Podaj ilość węglowodanów" },
                              numericality: { message: "Ilość węglowodanów podana niepoprawnie" }
  validate  :sum_of_values

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
    self.product_calories = (self.protein_kcal + self.fat_kcal + self.carbs_kcal).to_i
  end

  def sum_of_values
    sum = self.product_protein.to_f.round + self.product_fat.to_f.round + self.product_carbs.to_f.round
    if sum > 100
      errors.add(:protein, "Podaj prawidłowe ilości białka, tłuszczu i węglowodanów")
      errors.add(:carbs, "Podaj prawidłowe ilości białka, tłuszczu i węglowodanów")
      errors.add(:fat, "Podaj prawidłowe ilości białka, tłuszczu i węglowodanów")
    end
  end
end

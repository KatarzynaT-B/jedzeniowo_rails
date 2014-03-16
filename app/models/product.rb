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
end

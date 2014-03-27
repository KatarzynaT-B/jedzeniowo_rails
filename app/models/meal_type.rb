class MealType < ActiveRecord::Base
  has_many :dishes
  belongs_to :user

  validates :user, presence:   true
  validates :name, presence:   { message: "Podaj nazwę typu posiłku" },
                   uniqueness: { scope: :user_id, message: "Typ posiłku o takiej nazwie już istnieje" }

end

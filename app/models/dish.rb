class Dish < ActiveRecord::Base
  #before_save :count_dish_values

  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  validates :user,      presence:   true
  validates :dish_name, presence:   { message: "Podaj nazwę dania" },
                        uniqueness: { message: "Danie o takiej nazwie już istnieje" }
end

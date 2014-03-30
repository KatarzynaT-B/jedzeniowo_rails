class Meal < ActiveRecord::Base
  belongs_to :dish
  belongs_to :menu
  belongs_to :meal_type
end

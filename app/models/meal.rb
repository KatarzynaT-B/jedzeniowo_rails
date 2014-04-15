class Meal < ActiveRecord::Base
  belongs_to :dish
  belongs_to :menu, counter_cache: true
  belongs_to :meal_type
end

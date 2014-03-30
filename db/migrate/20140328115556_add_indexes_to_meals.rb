class AddIndexesToMeals < ActiveRecord::Migration
  def change
    add_index :meals, :dish_id
    add_index :meals, :meal_type_id
    add_index :meals, :menu_id
  end
end

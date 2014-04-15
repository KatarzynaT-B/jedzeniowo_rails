class AddIndexToMealTypes < ActiveRecord::Migration
  def change
    add_index :meal_types, :user_id
  end
end

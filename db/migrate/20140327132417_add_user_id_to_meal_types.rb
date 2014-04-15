class AddUserIdToMealTypes < ActiveRecord::Migration
  def change
    add_column :meal_types, :user_id, :integer
  end
end

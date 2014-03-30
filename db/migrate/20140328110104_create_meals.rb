class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :meal_type_id
      t.integer :dish_id
      t.integer :menu_id
      t.integer :position

      t.timestamps
    end
  end
end

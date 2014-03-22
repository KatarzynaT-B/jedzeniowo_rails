class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :steps
      t.float :dish_protein
      t.float :dish_fat
      t.float :dish_carbs
      t.integer :dish_calories

      t.timestamps
    end
  end
end
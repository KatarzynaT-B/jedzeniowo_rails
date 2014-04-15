class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :product_id
      t.integer :dish_id
      t.float :quantity_per_dish

      t.timestamps
    end
    add_index :ingredients, :product_id
    add_index :ingredients, :dish_id
  end
end

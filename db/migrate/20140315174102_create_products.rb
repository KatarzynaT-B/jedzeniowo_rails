class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :product_calories
      t.float :product_protein
      t.float :product_fat
      t.float :product_carbs
      t.integer :user_id

      t.timestamps
    end
    add_index :products, :user_id
  end
end

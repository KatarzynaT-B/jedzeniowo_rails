class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.date :menu_date
      t.integer :meals_no
      t.integer :menu_calories
      t.float :menu_protein
      t.float :menu_fat
      t.float :menu_carbs
      t.integer :user_id

      t.timestamps
    end
  end
end

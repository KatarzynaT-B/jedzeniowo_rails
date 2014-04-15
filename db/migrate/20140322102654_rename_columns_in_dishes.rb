class RenameColumnsInDishes < ActiveRecord::Migration
  def change
    rename_column :dishes, :name, :dish_name
    rename_column :dishes, :steps, :dish_steps
  end
end

class RenameColumnMealsNoToMenus < ActiveRecord::Migration
  def change
    rename_column :menus, :meals_no, :meals_count
  end
end

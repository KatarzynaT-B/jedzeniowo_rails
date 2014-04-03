class ChangeMealsCountInMenus < ActiveRecord::Migration
  def change
    change_column :menus, :meals_count, :integer, :default => 0

    Menu.find_each(select: 'id') do |menu|
      Menu.reset_counters(menu.id, :meals)
    end
  end
end

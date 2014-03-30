class AddIndexToMenu < ActiveRecord::Migration
  def change
    add_index :menus, :user_id
  end
end

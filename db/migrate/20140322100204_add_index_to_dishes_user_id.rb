class AddIndexToDishesUserId < ActiveRecord::Migration
  def change
    add_index :dishes, :user_id
  end
end

class AddUserIdToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :user_id, :string
  end
end

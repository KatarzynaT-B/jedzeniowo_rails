class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :gender
      t.integer :age
      t.integer :weight
      t.integer :height
      t.integer :activity_level
      t.float :calories_need
      t.float :protein_need
      t.float :fat_need
      t.float :carbs_need
      t.integer :user_id

      t.timestamps
    end
  end
end

class MealType < ActiveRecord::Base
  has_many :dishes
  belongs_to :user

  validates :user, presence:   true
  validates :name, presence:   true,
                   uniqueness: { scope: :user_id }

end

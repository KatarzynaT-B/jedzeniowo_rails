# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal do
    meal_type_id 1
    dish_id 1
    menu_id 1
    position 1
  end
end

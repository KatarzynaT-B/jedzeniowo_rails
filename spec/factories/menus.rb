# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu do
    menu_date "2014-03-28"
    meals_no 1
    menu_calories 1
    menu_protein 1.5
    menu_fat 1.5
    menu_carbs 1.5
    user_id 1
  end
end

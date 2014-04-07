# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    name "MyString"
    gender 1
    age 1
    weight 1
    height 1
    activity_level 1
    calories_need 1.5
    protein_need 1.5
    fat_need 1.5
    carbs_need 1.5
    user_id 1
  end
end

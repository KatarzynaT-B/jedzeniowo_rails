# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal_type do
    name "MyString"
    user
  end
end

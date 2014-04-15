# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    product
    dish
    quantity_per_dish 10
  end
end

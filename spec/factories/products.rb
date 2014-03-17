FactoryGirl.define do
  factory :product do
    product_name "MyString"
    product_protein 1.5
    product_fat 1.5
    product_carbs 1.5
    user
  end
end
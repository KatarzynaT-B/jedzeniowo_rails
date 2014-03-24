require 'spec_helper'

describe Ingredient do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }
  let(:dish) { create(:dish, user: user) }
  let(:ingredient) { build(:ingredient, product: product, dish: dish) }

  subject { ingredient }

  it { should respond_to(:product_id) }
  it { should respond_to(:dish_id) }
  it { should respond_to(:quantity_per_dish) }
  its(:dish) { should eq dish }
  its(:product) { should eq product }

  it { should be_valid }

  it { should validate_presence_of(:dish) }
  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:quantity_per_dish).with_message("Podaj ilość składnika potrzebną do przygotowania dania") }
  it { should validate_numericality_of(:quantity_per_dish).with_message("Ilość składnika podana niepoprawnie") }
end

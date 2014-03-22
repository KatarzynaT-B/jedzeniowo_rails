require 'spec_helper'

describe Dish do
  let(:user) { create(:user) }
  before do
    @dish = user.dishes.build(dish_name: 'danie', dish_steps: 'kolejne kroki')
  end
  subject { @dish }

  it { should respond_to(:dish_name) }
  it { should respond_to(:dish_steps) }
  it { should respond_to(:dish_protein) }
  it { should respond_to(:dish_fat) }
  it { should respond_to(:dish_carbs) }
  it { should respond_to(:dish_calories) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should respond_to(:ingredients) }

  it { should be_valid }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:dish_name).with_message("Podaj nazwę dania") }
  it { should validate_uniqueness_of(:dish_name).with_message("Danie o takiej nazwie już istnieje") }

end

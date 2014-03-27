require 'spec_helper'

describe MealType do
  let(:user) { create(:user) }
  before { @meal_type = user.meal_types.build(name: "dinner") }
  subject { @meal_type }

  it { should respond_to(:name) }
  it { should respond_to(:user) }
  it { should respond_to(:user_id) }
  its(:user) { should eq user }

  it { should be_valid }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name).with_message("Podaj nazwę typu posiłku") }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id).with_message("Typ posiłku o takiej nazwie już istnieje") }
end

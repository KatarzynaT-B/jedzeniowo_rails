require 'spec_helper'

describe Product do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @product = user.products.build(product_name: "produkt",
                                   product_calories: 100,
                                   product_protein: 1.9,
                                   product_fat: 3.7,
                                   product_carbs: 2.5)
  end

  subject { @product }

  it { should respond_to(:product_name) }
  it { should respond_to(:product_calories) }
  it { should respond_to(:product_protein) }
  it { should respond_to(:product_fat) }
  it { should respond_to(:product_carbs) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  context "when user is not present" do
      before { @product.user = nil }
      it { should_not be_valid }
    end

  context "when product_name is not present" do
      before { @product.product_name = nil }
      it { should_not be_valid }
    end

  context "when product_protein is not present" do
      before { @product.product_protein = nil }
      it { should_not be_valid }
    end

  context "when product_fat is not present" do
      before { @product.product_fat = nil }
      it { should_not be_valid }
    end

  context "when product_carbs is not present" do
      before { @product.product_carbs = nil }
      it { should_not be_valid }
    end

  context "when product_name is not unique" do
      let!(:product) { FactoryGirl.create(:product, product_name: "produkt", user: user) }
      it { should_not be_valid }
    end

  context "when product_protein is not a number" do
      before { @product.product_protein = "aaa" }
      it { should_not be_valid }
    end

  context "when product_fat is not a number" do
      before { @product.product_fat = "aaa" }
      it { should_not be_valid }
    end

  context "when product_carbs is not a number" do
      before { @product.product_carbs = "aaa" }
      it { should_not be_valid }
    end
end

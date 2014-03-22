require 'spec_helper'

describe Product do
  let(:user) { create(:user) }
  before do
    @product = user.products.build(product_name: "produkt",
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
  it { should respond_to(:protein_kcal) }
  it { should respond_to(:fat_kcal) }
  it { should respond_to(:carbs_kcal) }
  it { should respond_to(:count_calories) }
  it { should respond_to(:ingredients) }

  it { should be_valid }

  its(:protein_kcal) { should eq (4 * @product.product_protein.to_f).round }
  its(:fat_kcal) { should eq (9 * @product.product_fat.to_f).round }
  its(:carbs_kcal) { should eq (4 * @product.product_carbs.to_f).round }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:product_name).with_message("Podaj nazwę produktu") }
  it { should validate_presence_of(:product_protein).with_message("Podaj ilość białka") }
  it { should validate_presence_of(:product_fat).with_message("Podaj ilość tłuszczu") }
  it { should validate_presence_of(:product_carbs).with_message("Podaj ilość węglowodanów") }
  it { should validate_uniqueness_of(:product_name).with_message("Produkt o takiej nazwie już istnieje") }
  it { should validate_numericality_of(:product_protein).with_message("Ilość białka podana niepoprawnie") }
  it { should validate_numericality_of(:product_fat).with_message("Ilość tłuszczu podana niepoprawnie") }
  it { should validate_numericality_of(:product_carbs).with_message("Ilość węglowodanów podana niepoprawnie") }

  context "when count_calories called, product's calories should be updated" do
    before { @product.save }

    its(:product_calories) { should eq ((@product.protein_kcal + @product.fat_kcal + @product.carbs_kcal).to_i) }
  end

  #context "when user is not present" do
  #  before { @product.user = nil }
  #  it { should_not be_valid }
  #end

  #context "when product_name is not present" do
  #  before { @product.product_name = nil }
  #  it { should_not be_valid }
  #end

  #context "when product_protein is not present" do
  #  before { @product.product_protein = nil }
  #  it { should_not be_valid }
  #end
  #
  #context "when product_fat is not present" do
  #  before { @product.product_fat = nil }
  #  it { should_not be_valid }
  #end
  #
  #context "when product_carbs is not present" do
  #  before { @product.product_carbs = nil }
  #  it { should_not be_valid }
  #  end

  #context "when product_name is not unique" do
  #  let!(:product) { create(:product, product_name: "produkt", user: user) }
  #  it { should_not be_valid }
  #end
  #
  #context "when product_protein is not a number" do
  #  before { @product.product_protein = "aaa" }
  #  it { should_not be_valid }
  #end
  #
  #context "when product_fat is not a number" do
  #  before { @product.product_fat = "aaa" }
  #  it { should_not be_valid }
  #end
  #
  #context "when product_carbs is not a number" do
  #  before { @product.product_carbs = "aaa" }
  #  it { should_not be_valid }
  #end
end

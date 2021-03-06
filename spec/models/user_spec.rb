require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User",
                            email: "user@example.com",
                            password: "foobar",
                            password_confirmation: "foobar") }
  subject { @user }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:products) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should ensure_length_of(:password).is_at_least(6) }

  context "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  #context "name is not present" do
  #  before { @user.name = "" }
  #  it { should_not be_valid }
  #end

  #context "email is not present" do
  #  before { @user.email = "" }
  #  it { should_not be_valid }
  #end

  #context "name is too long" do
  #  before { @user.name = "a" * 51 }
  #  it {should_not be_valid}
  #end

  context "email format is invalid" do
    it "is invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "email format is valid" do
    it "is valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "email address already taken" do
    before do
      user_with_the_same_email = @user.dup
      user_with_the_same_email.email = @user.email.upcase
      user_with_the_same_email.save
    end
    it { should_not be_valid }
  end

  context "password not present" do
    before { @user = User.new(name: "Example User", email: "user@example.com", password: "", password_confirmation: "") }
    it { should_not be_valid }
  end

  #context "password too short" do
  #  before { @user.password = @user.password_confirmation = "a" * 5 }
  #  it { should be_invalid }
  #end

  context "password doesn't match confirmation" do
    before { @user.password = "barfoo" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    context "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  context "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "products associations" do
    before do
      @user.save
    end
    let!(:z_product) { create(:product, product_name: "z_product", user: @user) }
    let!(:a_product) { create(:product, product_name: "a_product", user: @user) }

    it "should have the right products in the right order" do
      expect(@user.products.to_a).to eq [a_product, z_product]
    end

    it "should destroy associated products" do
      create_many_products(@user)
      products = @user.products.to_a
      @user.destroy
      expect(products).not_to be_empty
      products.each do |product|
        expect(Product.where(id: product.id)).to be_empty
      end
    end
  end
end
require 'spec_helper'

describe "ProductPages" do
  subject { page }

  let(:logged_user) { create(:user) }
  before { sign_in logged_user }

  context "for logged in users" do
    it { should have_link("Produkty") }
  end

  describe "index" do

    context "when products not yet in database" do
      before do
        Product.delete_all
        visit products_path
      end

      it { should have_title("Nowy produkt") }
      it { should have_content("Dodaj produkt") }
    end

    context "when products present in database" do

      context "has proper title and heading" do
        let(:product) { build(:product, user: logged_user) }

        before do
          product.save
          visit products_path
        end
        after(:all) { Product.delete_all }
        it { should have_title("Produkty") }
        it { should have_content("Twoje produkty") }
      end

      #describe "pagination" do
      #
      #  @user = User.new(name: "User User",
      #                     email: "user@user.com",
      #                     password: "foobar",
      #                     password_confirmation: "foobar")
      #
      #  @user.save
      #
      #  create_many_products(@user)
      #
      #  after(:all) { Product.delete_all }
      #
      #  it { should have_selector('div.pagination') }
      #
      #  it "should list each product" do
      #    @user.products.paginate(page: 1).each do |product|
      #      expect(page).to have_content(product.product_name)
      #    end
      #  end
      #end
    end


  end



end

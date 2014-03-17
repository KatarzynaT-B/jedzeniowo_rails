require 'spec_helper'

describe "ProductPages" do
  subject { page }

  let(:logged_user) { create(:user) }
  before { sign_in logged_user }

  context "for logged in users" do
    it { should have_link("Produkty") }
  end

  describe "index" do

    context "with products not yet in database" do
      before { visit products_path }

      it { should have_title("Nowy produkt") }
      it { should have_content("Dodaj produkt") }
    end

    context "with products present in database" do

      context "has proper title and heading" do
        let(:product) { build(:product, user: logged_user) }

        before do
          product.save
          visit products_path
        end

        it { should have_title("Produkty") }
        it { should have_content("Twoje produkty") }
      end

      describe "pagination" do

        before do
          create_many_products(logged_user)
          visit products_path
        end

        it { should have_selector('div.pagination') }

        it "should list each product" do
          logged_user.products.limit(5).each do |product|
            expect(page).to have_content(product.product_name)
          end
        end
      end
    end
  end
end

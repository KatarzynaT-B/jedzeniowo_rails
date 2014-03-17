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

  context "adding new product" do
    before { visit new_product_path }
    let(:submit) { "Zapisz produkt" }

    context "with invalid product information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end

      context "after submission" do
        before { click_button submit }
        it { should have_title "Nowy produkt" }
        it { should have_content "error" }
      end
    end

    context "with valid product information" do
      before do
        fill_in "Nazwa produktu", with: "sample product"
        fill_in "białko", with: 14.3
        fill_in "tłuszcze", with: 14.3
        fill_in "węglowodany", with: 14.3
      end

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count)
      end

      it "should assign product to the proper user" do
        expect { click_button submit }.to change(logged_user.products, :count).by(1)
      end

      context "after saving the product" do
        before { click_button submit }
        let(:product) { Product.find_by(product_name: "sample product") }

        it { should have_title("Produkty") }
        it { should have_success_message("Produkt został dodany") }
        it { should have_content(product.product_name) }
        it { should have_content(product.product_calories) }
      end
    end
  end
end

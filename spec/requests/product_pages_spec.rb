require 'spec_helper'

describe "ProductPages" do
  subject { page }

  let(:logged_user) { create(:user) }
  before { sign_in logged_user }

  context "for logged in users" do
    it { should have_link("Produkty") }
  end

  context "deleting product" do
    before do
      create_many_products(logged_user)
      visit products_path
    end

    it { should have_link("usuń"), href: product_path(logged_user.products.first) }
    it "should destroy chosen product" do
      expect { click_link('usuń', match: :first) }.to change(Product, :count).by(-1)
    end
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
        it { should have_link("zmień", href: edit_product_path(product)) }
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
        specify { expect(product.product_calories).to be > 0 }
      end
    end
  end

  context "editing existing product" do
    let(:product) { create(:product, user: logged_user) }
    before do
      product.count_calories
      visit edit_product_path(product)
    end

    describe "page" do
      it { should have_title("Edycja produktu") }
      it { should have_content("Zmień dane produktu") }
      it { should have_link("Wróć do listy produktów", href: products_path) }
    end

    context "resigning and getting back to the products list" do
      let(:old_name) { product.product_name }
      let(:old_calories) { product.product_calories }
      before do
        click_link "Wróć do listy produktów"
      end
      specify { expect(product.reload.product_name).to eq old_name }
      specify { expect(product.reload.product_calories).to eq old_calories }
    end

    context "making changes in product's information" do
      let(:new_name) { "new product" }
      let(:new_protein) { 12.4 }
      let(:new_fat) { 11.1 }
      let(:new_carbs) { 3 }
      let(:new_calories) { ((4*new_protein).round + (9*new_fat).round + (4*new_carbs).round).to_i }
      before do
        fill_in "Nazwa produktu", with: new_name
        fill_in "białko", with: new_protein
        fill_in "tłuszcze", with: new_fat
        fill_in "węglowodany", with: new_carbs
        click_button "Zapisz zmiany"
      end

      it { should have_title("Produkty") }
      it { should have_success_message("zmieniony") }

      specify { expect(product.reload.product_name).to eq new_name }
      specify { expect(product.reload.product_protein).to eq new_protein }
      specify { expect(product.reload.product_fat).to eq new_fat }
      specify { expect(product.reload.product_carbs).to eq new_carbs }
      specify { expect(product.reload.product_calories).to eq new_calories }
    end

    context "with forbidden attributes" do
      let(:params) do
        { product: { product_name: "some_new", product_calories: 500 } }
      end

      before { patch product_path(product), params }
      specify { expect(product.reload.product_calories).not_to be eq 500 }
    end

    context "with invalid product information" do
      before do
        fill_in "Nazwa produktu", with: ""
        click_button "Zapisz zmiany"
      end
      it { should have_title "Edycja produktu" }
      it { should have_content "error" }
    end
  end
end

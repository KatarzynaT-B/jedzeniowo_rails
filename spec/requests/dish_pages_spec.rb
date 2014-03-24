require 'spec_helper'

describe "DishPages" do
  subject { page }
  let(:user) { create(:user) }
  before do
    create_many_products(user)
    sign_in user
  end

  context "for logged users" do
    it { should have_link("Dania") }
  end

  context "deleting dish" do
    before do
      create(:dish, user: user)
      create(:ingredient, dish: dish, product: Product.first)
      visit dishes_path
    end
    it { should have_link("usuń"), href: dish_path(logged_user.dishes(dish)) }
    it "should destroy chosen dish" do
      expect { click_link('usuń') }.to change(Product, :count).by(-1)

      it "should destroy associated ingredient" do
        expect { click_link('usuń') }.to change(Ingredient, :count).by(-1)
      end
    end
  end

  describe "index" do

    context "with dishes not yet in database" do
      before { visit dishes_path }

      it { should have_title("Nowe danie") }
      it { should have_content("Dodaj przepis na danie") }
    end

    context "with dishes present in database" do

      context "has proper title and heading" do
        let(:products) { create_many_products(user) }
        let(:dish) { create(:dish, user: user) }
        let(:ingredient) { create(:ingredient, dish: dish, product: Product.first) }

        before { visit dishes_path }

        it { should have_title("Dania") }
        it { should have_content("Twoje przepisy") }
        it { should have_link("zmień", href: edit_dish_path(dish)) }
      end

      #describe "pagination" do
      #
      #  before do
      #    create_many_dishes(user)
      #    visit products_path
      #  end
      #
      #  it { should have_selector('div.pagination') }
      #
      #  it "should list each product" do
      #    logged_user.products.limit(5).each do |product|
      #      expect(page).to have_content(product.product_name)
      #    end
      #  end
      #end
    end
  end

  context "adding new dish" do
    before { visit new_dish_path }
    let(:submit) { "Zapisz danie" }

    context "with invalid data" do
      it "should not create product" do
        expect { click_button submit }.not_to change(Dish, :count)
      end

      context "after submission" do
        before { click_button submit }
        it { should have_title "Nowe danie" }
        it { should have_content "error" }
      end
    end

    #context "with valida data" do
    #  pending
    #end
  end
end

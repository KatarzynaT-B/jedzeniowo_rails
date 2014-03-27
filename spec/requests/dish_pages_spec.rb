require 'spec_helper'

describe "DishPages" do
  subject { page }
  let(:user) { create(:user) }
  before { sign_in user }

  context "for logged users" do
    it { should have_link("Dania") }
  end

  context "deleting dish" do
    let!(:product) { create(:product, user: user) }
    let(:dish) { create(:dish, user: user) }
    before do
      create(:ingredient, dish: dish, product: Product.first)
      visit dishes_path
    end
    it { should have_link("usuń"), href: dish_path(user.dishes(dish)) }
    it "should destroy chosen dish" do
      expect { click_link('usuń') }.to change(Dish, :count).by(-1)
    end

    it "should destroy associated ingredient" do
      expect { click_link('usuń') }.to change(Ingredient, :count).by(-1)
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
        let(:product) { create(:product, user: user) }
        let!(:dish) { create(:dish, user: user) }
        let(:ingredient) { create(:ingredient, dish: dish, product: Product.first) }

        before { visit dishes_path }

        it { should have_title("Dania") }
        it { should have_content("Twoje dania") }
        it { should have_link("zmień", href: edit_dish_path(dish)) }
      end

      describe "pagination" do

        before do
          create_many_dishes(user)
          visit dishes_path
        end

        it { should have_selector('div.pagination') }

        it "should list each dish" do
          user.dishes.limit(5).each do |dish|
            expect(page).to have_content(dish.dish_name)
          end
        end
      end
    end
  end

  context "adding new dish" do
    let(:submit) { "Zapisz danie" }

    context "with invalid data" do
      before { visit new_dish_path }

      it "should not create product" do
        expect { click_button submit }.not_to change(Dish, :count)
      end

      context "after submission" do
        before { click_button submit }
        it { should have_title "Nowe danie" }
        it { should have_content "error" }
      end
    end

    context "with valida data" do

      before do
        create_many_products(user)
        visit new_dish_path
        fill_in "Nazwa dania:", with: "very sample dish"
        within '#dish_ingredients_attributes_0_product_id' do
          find("option[value='1']").click
        end
        fill_in "Ilość:", with: 4, match: :first
      end

      context "without using links to add ingredients" do

        it "should create a dish" do
          expect { click_button submit }.to change(Dish, :count).by(1)
        end

        it "should assign dish to the proper user" do
          expect { click_button submit }.to change(user.dishes, :count).by(1)
        end

        context "after saving the dish" do
          before { click_button submit }
          let(:dish) { Dish.find_by(dish_name: "very sample dish") }

          it { should have_title("Very Sample Dish") }
          it { should have_success_message("Danie zostało dodane") }
          it { should have_content(dish.dish_name.titleize) }
          it { should have_content(dish.dish_calories) }
          specify { expect(dish.dish_calories).to be > 0 }
        end
      end

      context "with using link to add ingredients" do

        before do
          click_link "Dodaj składnik"
          within '#dish_ingredients_attributes_1_product_id' do
            find("option[value='2']").click
          end
          fill_in "Ilość:", with: 4
        end

        it "should create a dish while using links to adding ingredients" do
          expect {click_button submit }.to change(Dish, :count).by(1)
        end
      end
    end
  end
end

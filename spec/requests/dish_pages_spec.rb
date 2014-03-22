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

    context "with valida data" do
      pending
    end
  end
end

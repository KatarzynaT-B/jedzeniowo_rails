require 'spec_helper'

describe "MealTypePages" do
  subject { page }

  let(:user) { create(:user) }

  before { sign_in user }

  context "deleting meal type" do
    before do
      create(:meal_type, user: user)
      visit meal_types_path
    end

    it { should have_link("usuń", href: meal_type_path(MealType.first)) }
    specify { expect { click_link('usuń', match: :first) }.to change(MealType, :count).by(-1) }
  end

  describe "index" do
    context "with meal types not yet in database" do
      before { visit meal_types_path }

      it { should have_title("Nowy typ posiłku") }
      it { should have_content("Dodaj typ posiłku") }
    end

    context "with meal types in database" do

      context "has proper title and heading" do
        before do
          create(:meal_type, user: user)
          visit meal_types_path
        end

        it { should have_title("Typy posiłków") }
        it { should have_content("Twoje typy posiłków") }
        it { should have_link("zmień", href: edit_meal_type_path(MealType.first)) }
        it { should have_content(MealType.first.name) }
      end
    end
  end

  context "adding new meal type" do
    before { visit new_meal_type_path }
    let(:submit) { "Zapisz typ" }

    context "with invalid data" do

      it "should not create a meal type" do
        expect { click_button submit }.not_to change(MealType, :count).by(1)
      end
      context "after submission" do
        before { click_button submit }
        it { should have_title("Nowy typ posiłku") }
        it { should have_content('error') }
      end
    end

    context "with valid data" do
      before { fill_in "Typ posiłku", with: "dinner" }
      it "should create a meal type" do
        expect { click_button submit }.to change(MealType, :count).by(1)
      end
      it "should assign meal type to the proper user" do
        expect { click_button submit }.to change(user.meal_types, :count).by(1)
      end
    end

  end

  context "editing existing meal type" do
    let(:meal_type) { create(:meal_type, user: user) }
    before { visit edit_meal_type_path(meal_type) }

    describe "page" do
      it { should have_title("Edycja typu posiłku") }
      it { should have_content("Zmień typ posiłku") }
      it { should have_link("Wróć do listy typów", href: meal_types_path) }
    end

    context "resignation and getting back to the meal types list" do
      let(:old_name) { meal_type.name }
      before { click_link "Wróć do listy typów" }

      specify { expect(meal_type.reload.name).to eq old_name }
    end

    context "changing meal type data" do
      before do
        fill_in "Typ posiłku", with: "new dinner"
        click_button "Zapisz zmiany"
      end

      it { should have_title("Typy posiłków") }
      it { should have_success_message("zmieniony") }

      specify { expect(meal_type.reload.name).to eq "new dinner" }
    end

    context "with invalid meal type data" do
      before do
        fill_in "Typ posiłku", with: ""
        click_button "Zapisz zmiany"
      end
      it { should have_title "Edycja typu posiłku" }
      it { should have_content "error" }
    end
  end
end

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_content("Zaloguj się") }
    it { should have_title("Logowanie") }
    it { should_not have_link("Produkty") }

    context "with invalid data" do
      before { click_button "Zaloguj" }

      it { should have_title("Logowanie") }
      it { should have_error_message("Nieprawidłowe") }

      context "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_error_message("Nieprawidłowe") }
      end
    end

    context "with valid data" do
      let(:user) { create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link("Twoje dane", href: user_path(user)) }
      it { should have_link(user.name) }
      it { should have_link("Wyloguj się", href: signout_path) }
      it { should_not have_link("Zaloguj się", href: signin_path) }
      it { should have_link("Produkty") }
      it { should have_link("Dania") }
      it { should have_link("Twoje profile") }
      it { should have_link("Typy posiłków", href: meal_types_path) }

      context "followed by signout" do
        before { click_link "Wyloguj się" }

        it { should have_link("Zaloguj się") }
      end
    end
  end

  describe "authorization" do

    context "for non-signed-in users" do
      let(:user) { create(:user) }

      context "when trying to visit protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Adres email", with: user.email
          fill_in "Hasło", with: user.password, match: :prefer_exact
          click_button "Zaloguj"
        end

        describe "after signing in" do
          it "should rendered the desired protected page" do
            expect(page).to have_title("Zmień dane")
          end

          describe "when signing in again" do
            before do
              click_link "Wyloguj się"
              visit signin_path
              fill_in "Adres email", with: user.email
              fill_in "Hasło", with: user.password
              click_button "Zaloguj"
            end

            it "should render the default profile page" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

      describe "in the Users controller" do

        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title("Logowanie") }
        end

        context "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting the user index" do
          before { visit users_path }
          it { should have_title("Logowanie") }
        end
      end

      describe "in the Products controller" do
        let(:product) { create(:product, user: user) }

        context "visiting the index page" do
          before { visit products_path }
          it { should have_title("Logowanie") }
        end

        context "submitting to the update action" do
          before { patch product_path(product) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting the edit page" do
          before { visit edit_product_path(product) }
          it { should have_title("Logowanie") }
        end
      end

      describe "in the MealTypes controller" do
        let(:meal_type) { create(:meal_type, user: user) }

        context "visiting the index page" do
          before { visit meal_types_path }
          it { should have_title("Logowanie") }
        end

        context "submittinf to the update action" do
          before { patch meal_type_path(meal_type) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting the edit page" do
          before { visit edit_meal_type_path(meal_type) }
          it { should have_title("Logowanie") }
        end
      end

      describe "in the Dishes controller" do
        before { create_many_dishes(user) }

        context "visiting the index page" do
          before { visit dishes_path }
          it { should have_title("Logowanie") }
        end

        context "submitting to the update action" do
          before { patch dish_path(user.dishes.first) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        context "visiting the edit page" do
          before { visit edit_dish_path(user.dishes.first) }
          it { should have_title("Logowanie") }
        end
      end
    end

    context "for signed-in users" do
      let(:user) { create(:user) }
      before { sign_in user, no_capybara: true }

      context "submitting to the new user action" do
        before { get new_user_path }
        specify { expect(response).to redirect_to(root_url) }
      end

      context "submitting to the create user action" do
        before { post users_path }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    context "as wrong user" do
      let(:user) { create(:user) }
      let(:wrong_user) { create(:user, email: "wrong@example.com") }

      before { sign_in user, no_capybara: true }

      context "submitting a GET request to the User#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title("Zmień dane")) }
        specify { expect(response).to redirect_to(root_url) }
      end

      context "submitting a PATCH request to the User#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end

      context "cannot see other users' products" do
        #let(:products) { create_many_products(wrong_user) }
        #let(:dishes) { create_many_dishes(wrong_user) }

        context "on the product index page" do
          before { get products_path }
          specify { expect(response.body).not_to match(full_title("Produkty")) }
        end

        context "while adding new dish" do
          before do
            create_many_products(user)
            create(:product, product_name: "wrong_user_product", user: wrong_user)
            get new_dish_path
          end
          specify { expect(response.body).not_to include("wrong_user_product") }
        end
      end

      context "cannot see other users' dishes" do
        context "on the dishes index page" do
          before { get dishes_path }
          specify { expect(response.body).not_to match(full_title("Dania")) }
        end
      end

      context "cannot see other users' meal types" do
        context "on the meal_types index page" do
          before { get meal_types_path }
          specify { expect.(response.body).not_to match(full_title("Typy posiłków")) }
        end
      end
    end

    context "as non-admin user" do
      let(:user) { create(:user) }
      let(:non_admin) { create(:user, email: "example@user.com") }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a GET request to the User#index action" do
        before { visit users_path }
        it { should have_title(full_title('')) }
      end

      describe "submitting a DELETE request to the User#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end

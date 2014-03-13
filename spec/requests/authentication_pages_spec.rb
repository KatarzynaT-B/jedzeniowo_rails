require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_content("Zaloguj się") }
    it { should have_title("Logowanie") }

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
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link("Twoje dane", href: user_path(user)) }
      it { should have_link("Wyloguj się", href: signout_path) }
      it { should_not have_link("Zaloguj się", href: signin_path) }

      context "followed by signout" do
        before { click_link "Wyloguj się" }

        it { should have_link("Zaloguj się") }
      end
    end
  end

  describe "authorization" do

    context "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

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
    end

    context "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

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
    end
  end
end

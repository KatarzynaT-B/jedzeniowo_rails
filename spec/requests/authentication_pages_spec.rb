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
      before { valid_signin(user) }

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
end

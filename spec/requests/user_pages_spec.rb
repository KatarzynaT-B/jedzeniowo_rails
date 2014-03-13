require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Załóż konto" }

    context "with invalid user data" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      context "after submission" do
        before { click_button submit }

        it { should have_title("Załóż konto") }
        it { should have_content("error") }
      end
    end

    context "with valid user data" do
      before do
        fill_in "Nazwa użytkownika", with: "Example User"
        fill_in "Adres email", with: "user@example.com"
        fill_in "Hasło", with: "foobar", match: :prefer_exact
        fill_in "Potwierdź hasło", with: "foobar", match: :prefer_exact
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_sussess_message('Witamy') }
        it { should have_link("Wyloguj się", href: signout_path) }
      end
    end

    it { should have_content('Załóż konto!') }
    it { should have_title(full_title("Załóż konto")) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content("Twoje dane") }
    it { should have_title(user.name) }
  end
end

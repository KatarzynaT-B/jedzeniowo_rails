require 'spec_helper'

describe "UserPages" do
  subject { page }

  context "as an admin user" do
    let(:admin) { create(:admin) }

    before(:each) do
      sign_in admin
      visit users_path
    end

    describe "index" do

      it { should have_title("Użytkownicy") }
      it { should have_content("Użytkownicy aplikacji") }

      describe "pagination" do

        before(:all) { create_many_users }
        after(:all) { User.delete_all }

        it { should have_selector('div.pagination') }

        it "should list each user" do
          User.paginate(page: 1).each do |user|
            expect(page).to have_selector('li', text: user.name)
          end
        end
      end
    end

    describe "delete links" do

      before do
        create(:user, email: "aser1@example.com")
        create(:user, email: "aser2@example.com")
        create(:user, email: "aser3@example.com")
        visit users_path
      end

      it { should have_link('usuń', href: user_path(User.last)) }

      it "should be able to delete another user" do
        expect { click_link('usuń', match: :first) }.to change(User, :count).by(-1)
      end

      it { should_not have_link('usuń', href: user_path(admin)) }
    end
  end

  describe "signup" do
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
        it { should have_success_message('Witamy') }
        it { should have_link("Wyloguj się", href: signout_path) }
      end
    end

    it { should have_content('Załóż konto!') }
    it { should have_title(full_title("Załóż konto")) }
  end

  describe "show user data" do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it { should have_content("Twoje dane") }
    it { should have_title(user.name) }
    it { should have_link("Zmień dane", href: edit_user_path(user)) }
  end

  describe "edit" do
    let(:user) { create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content('Zmień swoje dane') }
      it { should have_title("Zmień dane") }
    end

    context "with invalid information" do
      before { click_button "Zapisz zmiany" }

      it { should have_content('error') }
    end

    context "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Nazwa użytkownika", with: new_name
        fill_in "Adres email", with: new_email
        fill_in "Hasło", with: user.password, match: :prefer_exact
        fill_in "Potwierdź hasło", with: user.password, match: :prefer_exact
        click_button "Zapisz zmiany"
      end

      it { should have_title(new_name) }
      it { should have_success_message("zapisane") }
      it { should have_link("Wyloguj się", signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    context "with forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password, password_confirmation: user.password } }
      end

      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end
end

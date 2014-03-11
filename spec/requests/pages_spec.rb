require 'spec_helper'

describe "Pages" do
  subject { page }

  context "Home page" do
    before { visit root_path }

    it { should have_content("Witaj!") }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  context "About page" do
    before { visit about_path }

    it { should have_content("O aplikacji") }
    it { should have_title(full_title('O nas')) }
  end

end

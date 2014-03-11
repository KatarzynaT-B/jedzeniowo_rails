require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Załóż konto!') }
    it { should have_title(full_title("Załóż konto")) }
  end
end

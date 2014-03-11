require 'spec_helper'

describe "Pages" do
  subject { page }

  shared_examples_for "all_static_pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  context "Home page" do
    before { visit root_path }
    let(:heading) { "Witaj!" }
    let(:page_title) { '' }

    it { should_behave_like "all static pages" }
    it { should_not have_title('| Home') }
  end

  context "About page" do
    before { visit about_path }
    let(:heading) { "O aplikacji" }
    let(:page_title) { 'O nas' }

    it { should_behave_like "all static pages" }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "O nas"
    expect(page).to have_title(full_title('O nas'))
    click_link "Home"
    click_link "Załóż konto!"
    expect(page).to have_title(full_title('Załóż konto'))
    click_link "Jedzeniowo"
    expect(page).to have_title(full_title(''))
  end
end

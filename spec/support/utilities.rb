include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_sussess_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in "Adres email", with: user.email
    fill_in "Hasło", with: user.password, match: :prefer_exact
    click_button "Zaloguj"
  end
end

def create_many_users
  names_list = %w(Alice Bob Ben Cindy Dana)
  names_list.each do |name_given|
    FactoryGirl.create(:user, name: name_given,
                       email: "#{name_given.downcase}@example.com")
  end
end
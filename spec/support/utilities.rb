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

def create_many_products(user)
  products_list=%w(produkt_1 produkt_2 produkt_3 produkt_4 produkt_5)
  products_list.each do |product|
    user.products.create!(product_name: product,
                                       product_calories: 100,
                                       product_protein: 1.9,
                                       product_fat: 3.7,
                                       product_carbs: 2.5)
  end
end
include ApplicationHelper

def valid_signin(user)
  fill_in "Username or email", with: user.name
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit root_path
    fill_in "Username or email", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
def sign_in(user)
  valid_password = "12345678"
  visit new_user_session_path

  fill_in "Email", with: user.email
  fill_in "Password", with: valid_password
  within(".simple_form") do
    click_button "Sign in"
  end
end

def sign_up(user)
  valid_password = 12345678
  fill_in "Email", with: user.email
  fill_in "user[password]", with: valid_password
  fill_in "user[password_confirmation]", with: valid_password
  fill_in "Username", with: user.username
  fill_in "First name", with: user.first_name
  fill_in "Last name", with: user.last_name

  click_on "Submit"
end

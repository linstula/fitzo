def sign_in(user)
  valid_password = "12345678"
  visit new_user_session_path

  fill_in "Email", with: user.email
  fill_in "Password", with: valid_password
  within(".simple_form") do
    click_button "Sign in"
  end
end
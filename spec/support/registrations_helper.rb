def sign_up_trainer(trainer)
  valid_password = 12345678

  visit root_path
  click_on "Get Listed"
  
  fill_in "Email", with: trainer[:email]
  fill_in "user[password]", with: valid_password
  fill_in "user[password_confirmation]", with: valid_password
  fill_in "Username", with: trainer[:username]
  fill_in "First name", with: trainer[:first_name]
  fill_in "Last name", with: trainer[:last_name]

  click_on "Submit"
  click_on "Sign out"
end

def sign_up_member(member)
  valid_password = 12345678

  visit root_path
  click_button "Sign up"
  
  fill_in "Email", with: member[:email]
  fill_in "user[password]", with: valid_password
  fill_in "user[password_confirmation]", with: valid_password
  fill_in "Username", with: member[:username]
  fill_in "First name", with: member[:first_name]
  fill_in "Last name", with: member[:last_name]

  click_on "Submit"
end

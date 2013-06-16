require "spec_helper"

feature "A user signing in" do
  
  let!(:registered_user) { FactoryGirl.create(:user) }

  scenario "can sign in if they are a registered user" do
    valid_password = "12345678"
    visit root_path
    click_link "Sign in"

    fill_in "Email", with: registered_user.email
    fill_in "Password", with: valid_password
    within (".simple_form") do
      click_button "Sign in"
    end

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_link("Sign out")
    # expect(user_signed_in?).to be true
    # redirects to profile if trainer
    # redirects to search page if user

  end

  scenario "is not signed in if they enter invalid information" do
    visit root_path

    click_link "Sign in"

    fill_in "Email", with: "InvalidEmail"
    fill_in "Password", with: "WrongPassword"

    within ".simple_form" do
      click_button "Sign in"
    end

    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_content("Invalid email or password")
  end

end
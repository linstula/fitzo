require "spec_helper"

describe "A user signing in" do
  
  let!(:registered_user) { FactoryGirl.create(:user) }

  it "can sign in if they are a registered user" do
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
  end

end
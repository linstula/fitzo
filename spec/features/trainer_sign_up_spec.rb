require 'spec_helper'

describe "A Trainer signing up" do
  
  it "can create an account" do
    prev_count = User.count

    visit root_path

    click_on "Get Listed"

    fill_in "Username", with: "My_username"
    fill_in "Email", with: "my_email@example.com"
    fill_in "user[password]", with: "12345678"
    fill_in "user[password_confirmation]", with: "12345678"
    fill_in "First name", with: "FirstName"
    fill_in "Last name", with: "LastName"

    click_on "Submit"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(User.count).to eql(prev_count + 1)
  end

end
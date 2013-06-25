require 'spec_helper'

feature "A Member signing up" do

  let(:member) { FactoryGirl.build(:member) }

  it "can create an account" do
    prev_count = User.count
    visit root_path

    click_button "Sign up"

    fill_in "Email", with: member[:email]
    fill_in "user[password]", with: 12345678
    fill_in "user[password_confirmation]", with: 12345678
    fill_in "Username", with: member[:username]
    fill_in "First name", with: member[:first_name]
    fill_in "Last name", with: member[:last_name]
    click_on "Submit"

    expect(User.count).to eql(prev_count + 1)
    expect(current_path).to eql(root_path)
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  it "does not have a profile page" do
    prev_count = TrainerProfile.count
    visit root_path

    click_button "Sign up"

    fill_in "Email", with: member[:email]
    fill_in "user[password]", with: 12345678
    fill_in "user[password_confirmation]", with: 12345678
    fill_in "Username", with: member[:username]
    fill_in "First name", with: member[:first_name]
    fill_in "Last name", with: member[:last_name]
    click_on "Submit"

    expect(TrainerProfile.count).to eql(prev_count)
  end
end

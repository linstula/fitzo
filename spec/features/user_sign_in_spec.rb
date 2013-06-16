require "spec_helper"

describe "A user signing in" do
  
  let(:registered_user) { FactoryGirl.build(:user) }

  it "can sign in if they are a registered user" do
    
    visit root_path
    click_on "Sign in"

    fill_in "Email", with: registered_user.email
    fill_in "Password", with: registered_user.password

    expect(page).to have_content("Successfully signed in")
    expect(page).to have_selector(link_or_button: "Sign out")
    expect(current_user).to eql(registered_user)
  end

end
require 'spec_helper'

feature "Signing out" do
  
  let!(:user) { FactoryGirl.create(:user) }

  scenario "when clicking the sign out button" do
    sign_in(user)

    click_link "Sign out"

    expect(current_path).to eql(root_path)
    expect(page).to have_content("Signed out successfully.")
  end

end
require 'spec_helper'

feature "Sign out" do
  
  let!(:member) { FactoryGirl.create(:member) }

  scenario "is successful when clicking the sign out button" do
    sign_in(member)

    click_link "Sign out"

    expect(current_path).to eql(root_path)
    expect(page).to have_content("Signed out successfully.")
  end

end

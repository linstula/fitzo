require 'spec_helper'

# as a user
# I want to edit my account
# so I can keep my info current

# Acceptance Criteria:
# * I don't see an edit menu if I'm not signed in
# * I can click on a drop down menu and click a link to edit my account info
# * I can edit all account info except my role
# * I can delete my account
# * Trainers see another link to edit their profile

feature "Editing a user account" do

  let!(:member)     { FactoryGirl.create(:member) }
  let!(:trainer)  { FactoryGirl.create(:trainer) }
  
  describe "when a user is not signed in" do

    it "does not see an edit menu" do
      not_logged_in_member = member
      visit root_path

      expect(page).to_not have_link("#{not_logged_in_member.username}")
    end

  end

  describe "when a user is signed in as a user" do

    it "can see an edit menu" do
      sign_in(member)

      expect(page).to have_link("#{member.username}")
    end

  end

  scenario "when a user is signed in as a trainer"

  describe "deleting an account" do

    it "when I'm signed in" do
      sign_in(member)
      prev_count = User.count

      visit edit_user_registration_path
      click_on "Cancel my account"

      expect(User.count).to eql(prev_count - 1)
      expect(page).to have_content("Bye! Your account was 
        successfully cancelled. We hope to see you again soon.")
    end

    it "when I'm not signed in" do 
      prev_count = User.count

      visit edit_user_registration_path

      expect(User.count).to eql(prev_count)
    end
  end


end

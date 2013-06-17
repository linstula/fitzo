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

  let!(:user)     { FactoryGirl.create(:user) }
  let!(:trainer)  { FactoryGirl.create(:trainer) }
  
  describe "when a user is not signed in" do

    it "does not see an edit menu" do
      not_logged_in_user = user
      visit root_path

      expect(page).to_not have_link("#{not_logged_in_user.username}")
    end

  end

  describe "when a user is signed in as a user" do

    it "can see an edit menu" do
      sign_in(user)

      expect(page).to have_link("#{user.username}")
    end

  end

  scenario "when a user is signed in as a trainer"

  scenario "trying to edit another users account"

  scenario "deleting an account"


end
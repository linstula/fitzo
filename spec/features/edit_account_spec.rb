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

feature "Edit a user account" do

  let(:member)     { FactoryGirl.create(:member) }
  let(:trainer)  { FactoryGirl.create(:trainer) }
  
  describe "when a user is not signed in" do

    it "does not see an edit menu" do
      visit root_path

      expect(page).to_not have_link("#{member.username}")
    end

  end

  describe "when a user is signed in" do

    it "member can see an edit menu" do
      sign_in(member)

      expect(page).to have_link("#{member.username}")
    end

    it "trainer can see an edit menu" do
      sign_in(trainer)

      expect(page).to have_link("#{trainer.username}")
    end
  end
end

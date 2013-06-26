require "spec_helper"

describe "A signed in trainer" do

  context "signed in as a trainer" do
    let(:trainer) { FactoryGirl.create(:trainer) }

    it "can access an edit profile page" do
      trainer.build_trainer_profile.save
      sign_in(trainer)

      click_on "Edit Profile"

      expect(current_path).to eql(edit_trainer_profile_path(trainer.trainer_profile))
    end
  end

  context "signed in as a user" do

    let(:member) { FactoryGirl.create(:member) }
    let(:trainer) { FactoryGirl.build(:trainer) }

    it "cannot access a trainer's  edit profile page" do
      sign_up(trainer)
      click_on "Sign out"
      new_trainer = User.last
      profile = new_trainer.trainer_profile

      click_on "Sign in"

      fill_in "Email", with: member[:email]
      fill_in "Password", with: 12345678
      click_button "Sign in"

      expect(page).to_not have_link("Edit Profile")
      
      visit edit_trainer_profile_path(profile)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied.")
    end
  end
end

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

    it "cannot access an edit profile page" do
      sign_in(member)

      expect(page).to_not have_link("Edit Profile")
      
      visit edit_user_trainer_profile_path(member)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Resource not available.")
    end

  end
end

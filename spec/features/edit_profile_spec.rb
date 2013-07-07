require "spec_helper"

feature "Edit a profile" do

  let(:profile)       { FactoryGirl.create(:trainer_profile) }
  let(:trainer)       { profile.user }
  let(:member)        { FactoryGirl.create(:member) }
  let(:other_trainer) { FactoryGirl.create(:trainer) }

  context "a registered trainer" do

    it "can add profile info" do
      sign_in(trainer)
      visit edit_trainer_profile_path(profile)

      fill_in "Phone number", with: "0987654321"
      fill_in "Website", with: "trainer@trainer.com"
      fill_in "About", with: "This is some interesting text."

      click_on "Update info"

      # this test is failing and i don't know why...
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content("Profile updated")
      expect(profile.phone_number).to eql("0987654321")
      expect(profile.website).to eql("trainer@trainer.com")
      expect(profile.about).to eql("This is some interesting text.")
    end

  end

  context "an unauthorized user" do

    describe "guest user" do
      it "cannot access trainer's profile edit page" do
        visit edit_trainer_profile_path(profile)
        expect(current_path).to eql(new_user_session_path)
      end
    end

    describe "member" do
      it "cannot access trainer's profile edit page" do
        sign_in(member)
        visit edit_trainer_profile_path(profile)
        expect(current_path).to eql(root_path)
        expect(page).to have_content("Access denied")
      end
    end

    describe "other trainer" do
      it "cannot access trainer's profile edit page" do
        sign_in(other_trainer)
        visit edit_trainer_profile_path(profile)
        expect(current_path).to eql(root_path)
        expect(page).to have_content("Access denied")
      end
    end
  end


end

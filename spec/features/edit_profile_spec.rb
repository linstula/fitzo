require "spec_helper"

feature "Edit a profile" do

  let(:trainer)       { FactoryGirl.create(:trainer) }
  let(:profile)       { trainer.trainer_profile }
  let(:member)        { FactoryGirl.create(:member) }
  let(:other_trainer) { FactoryGirl.create(:trainer) }

  context "a registered trainer" do

    # it "can add a phone number" do
    #   visit trainer_profile_path
    # end

  end

  context "an unauthorized user" do

    describe "guest user" do
      it "cannot access trainer's profile edit page" do
        visit edit_trainer_profile_path(profile)
        expect(current_path).to eql(new_user_session_path)
        expect(page).to have_content("You need to sign in or sign up before continuing")
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

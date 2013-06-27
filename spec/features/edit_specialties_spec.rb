require "spec_helper"

feature "Edit specialties" do

  let(:trainer) { FactoryGirl.create(:trainer) }
  let(:profile) { trainer.trainer_profile }

  context "registered trainer" do

    let!(:specialty) { FactoryGirl.create(:specialty) }
    let!(:specialty_2) { FactoryGirl.create(:specialty) }

    it "can edit their specialties" do
      sign_in(trainer)
      visit edit_trainer_profile_path(profile)
      prev_count = profile.trainer_specialties.count

      check specialty.title
      check specialty_2.title
      click_on "Update Trainer profile"

      expect(profile.trainer_specialties.count).to eql(2)

      visit edit_trainer_profile_path(profile)

      uncheck(specialty.title)
      uncheck(specialty_2.title)
      click_on "Update Trainer profile"

      expect(profile.trainer_specialties.count).to eql(0)

      visit trainer_profile_path(profile)
      expect(page).to_not have_content("Body Building")
    end
  end

  context "an un-authorized user" do

    let(:other_trainer)     { FactoryGirl.create(:trainer) }
    let(:member)            { FactoryGirl.create(:member) }

    it "guest user cannot modify a trainer's specialties" do
      visit edit_trainer_profile_path(profile)

      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end

    it "member cannot modify a trainer's specialties" do
      sign_in(member)
      visit edit_trainer_profile_path(profile)

      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end

    it "other trainer cannot modify a trainer's specialties" do
      sign_in(other_trainer)
      visit edit_trainer_profile_path(profile)

      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end
end

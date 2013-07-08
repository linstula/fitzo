require "spec_helper"

feature "Trainer selects specialties", %{
  as a trainer
  I want to select what specialties I have
  so users know what skills I have
} do

  # Acceptance Criteria
  # * I can select specialties from an existing list
  # * Only I can add specialties to my profile
  # * I  can select multiple specialties

  let(:trainer) { FactoryGirl.create(:trainer) }
  let(:profile) { trainer.trainer_profile }

  context "a signed in trainer" do

    let!(:specialty) { FactoryGirl.create(:specialty) }
    let!(:specialty_2) { FactoryGirl.create(:specialty) }

    it "can select specialties" do
      sign_in(trainer)
      prev_count = profile.trainer_specialties.count

      visit edit_trainer_profile_path(profile)
      check specialty.title
      check specialty_2.title
      click_on "Update Specialties"

      expect(profile.trainer_specialties.count).to eql(prev_count + 2)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content("Specialties updated")
    end

    it "can see new specialties on their profile" do
      sign_in(trainer)
      visit edit_trainer_profile_path(profile)

      check specialty.title
      click_on "Update Specialties"

      visit trainer_profile_path(profile)

      expect(page).to have_content(specialty.title)
    end
  end
end

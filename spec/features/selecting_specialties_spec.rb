require "spec_helper"

feature "selecting specialties", %{
  as a trainer
  I want to select what specialties I have
  so users know what skills I have
} do

  # Acceptance Criteria
  # * I can select specialties form an existing lsit
  # * Only I can add specialties to my profile
  # * I can click on a button in my profile to add a specialty
  # * I am redirected to a select specialties page
  # * I  can select multiple specialties

  let(:trainer_attr) { FactoryGirl.attributes_for(:trainer) }
  let(:register_trainer) { sign_up_trainer(trainer_attr) }

  context "a signed in trainer" do
    it "can select specialties" do
      register_trainer
      trainer = User.last
      sign_in(trainer)
      profile = trainer.trainer_profile
      prev_count = profile.trainer_specialties.count

      visit edit_trainer_profile_path(profile)
      click_on "Edit Specialties"
      save_and_open_page
      check "Body Building"
      check "Marathon Running"

      click_on "Save"

      expect(profile.trainer_specialties.count).to eql(prev_count + 2)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content("Specialties saved.")
    end
  end

  context "an un-authorized user"

end

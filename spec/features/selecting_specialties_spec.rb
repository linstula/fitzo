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

  context "a signed in trainer" do

    let(:trainer_attr) { FactoryGirl.attributes_for(:trainer) }
    let(:register_trainer) { sign_up_trainer(trainer_attr) }
    let!(:specialty) { FactoryGirl.create(:specialty) }
    let!(:specialty_2) { FactoryGirl.create(:specialty) }

    it "can select specialties" do
      register_trainer
      trainer = User.last
      sign_in(trainer)
      profile = trainer.trainer_profile
      prev_count = profile.trainer_specialties.count

      visit edit_trainer_profile_path(profile)
      check specialty.title
      check specialty_2.title
      click_on "Update Trainer profile"

      expect(profile.trainer_specialties.count).to eql(prev_count + 2)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content("Profile updated")
    end

    it "can see their specialties on their profile" do
      register_trainer
      trainer = User.last
      sign_in(trainer)
      profile = trainer.trainer_profile

      profile.trainer_specialties.create(trainer_profile_id: profile.id, specialty_id: specialty.id)

      visit trainer_profile_path(profile)

      expect(page).to have_content(specialty.title)
    end

    it "can edit their specialties" do
      register_trainer
      trainer = User.last
      sign_in(trainer)
      profile = trainer.trainer_profile

      profile.trainer_specialties.create(trainer_profile_id: profile.id,
        specialty_id: specialty.id)

      profile.trainer_specialties.create(trainer_profile_id: profile.id,
        specialty_id: specialty_2.id)

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

    let(:trainer)     { FactoryGirl.create(:trainer) }
    let(:specialty)        { FactoryGirl.create(:specialty) }
    let(:specialty_2)      { FactoryGirl.create(:specialty) }
    let(:profile)           { trainer.trainer_profile }
    let!(:trainer_specialty){ FactoryGirl.create(:trainer_specialty, trainer_profile: profile, specialty: specialty)}
    let!(:trainer_specialty2){ FactoryGirl.create(:trainer_specialty, trainer_profile: profile, specialty: specialty_2)}
    let(:member)            { FactoryGirl.create(:member) }

    it "can see specialties on the trainer's profile" do
      visit trainer_profile_path(profile)

      expect(page).to have_content(specialty.title)
      expect(page).to have_content(specialty_2.title)
    end

    it "cannot modify a trainer's specialties" do
      trainer = User.last
      profile = trainer.trainer_profile

      visit edit_trainer_profile_path(profile)

      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")

      sign_in(member)
      visit edit_trainer_profile_path(profile)

      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end

end

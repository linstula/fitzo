require "spec_helper"

feature "trainer adds a specialty", %{
  as a trainer
  I want to add specialties to my profile
  so users know what skills I have
} do

  # Acceptance Criteria
  # * Only I can add specialties to my profile
  # * I can add a service on my edit profile page
  # * I am redirected to a add specialty page
  # * I must specify a specialty title
  # * Form must try to find standardized results 
  #   from DB for the specialty

  # let(:trainer_profile) { FactoryGirl.create(:trainer_profile) }
  let(:trainer)         { FactoryGirl.create(:trainer) }
  let(:specialty_attr)  {  FactoryGirl.attributes_for(:specialty)}
  
  context "a signed-in trainer" do
    before(:each) do
      trainer.build_trainer_profile.save
      @prev_count = trainer.trainer_profile.specialties.count
      sign_in(trainer)
      visit edit_trainer_profile_path(trainer.trainer_profile)
      click_on "Add Specialty"
    end

    it "adds a specialty with valid attributes" do
      fill_in_specialty(specialty_attr)

      click_on "Create Specialty"
      specialty = Specialty.last

      expect(trainer_profile.specialties.count).to eql(@prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(trainer.trainer_profile))
      expect(page).to have_content(specialty_attr[:title])
      expect(page).to have_content("Service added.")
    end

    it "can see a newly created specialty on the profile page" do
      fill_in_specialty(specialty_attr)

      click_on "Create Specialty"

      visit user_trainer_profile_path(trainer)

      expect(page).to have_content(specialty_attr[:title])
    end
  end


end

def fill_in_specialty(specialty)
  fill_in "Title", with: specialty[:title]
end

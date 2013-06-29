require "spec_helper"

feature "Trainer adds location" do

  let(:trainer)   { FactoryGirl.create(:trainer) }
  let(:profile)   { trainer.trainer_profile }
  let(:location)  { FactoryGirl.attributes_for(:location) }

  context "registered trainer" do

    it "can add a location with valid attributes" do
      sign_in(trainer)
      prev_count = profile.locations.count
      visit edit_trainer_profile_path(profile)

      click_on "Add a Location"
      fill_in_location_form(location)
      click_on "Add Location"

      expect(profile.locations.count).to eql(prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content(location[:street_address])
      expect(page).to have_content("Location added.")
    end
    
    it "cannot add a location with invalid attributes" do
      sign_in(trainer)
      prev_count = profile.locations.count
      visit edit_trainer_profile_path(profile)

      click_on "Add a Location"
    
      click_on "Add Location"

      expect(profile.locations.count).to eql(prev_count)
      expect(current_path).to eql(new_trainer_profile_location_path(profile))
      expect(page).to have_content("Location could not be added.")
    end

    it "must specify a location from a list if the entered location is ambiguous" do
      sign_in(trainer)
      prev_count = profile.locations.count
      visit edit_trainer_profile_path(profile)

      click_on "Add a Location"
      fill_in "Street address", with: "000"
      fill_in "City", with: "NotARealCity"
      fill_in "State", with: "ZZ"
      click_on "Add Location"

      expect(profile.locations.count).to eql(prev_count)
      expect(page).to have_content("Select your location")

      # select one of the search results
      # click submit

      expect(profile.locations.count).to eql(prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content(#selection street_address)
      expect(page).to have_content("Location added.")
    end
    
    it "can have more than one location"

  end

  context "unauthorized user" do

    describe "guest user" do
    end

    describe "member" do
    end

    describe "other trainer" do
    end
  end


end

def fill_in_location_form(location)
  fill_in "Street address", with: location[:street_address]
  fill_in "City", with: location[:city]
  fill_in "State", with: location[:state]
end

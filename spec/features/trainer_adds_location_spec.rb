require "spec_helper"

feature "Trainer adds location", :vcr do

  let(:trainer)       { FactoryGirl.create(:trainer) }
  let(:profile)       { trainer.trainer_profile }
  let(:location)      { FactoryGirl.attributes_for(:location) }
  let(:member)        { FactoryGirl.create(:member) }
  let(:other_trainer) { FactoryGirl.create(:trainer) }

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
      expect(page).to have_content("We couldn't find that address.")
    end

    it "cannot create an ambiguous location" do
      sign_in(trainer)
      prev_count = profile.locations.count
      visit edit_trainer_profile_path(profile)

      click_on "Add a Location"
      fill_in "Street address", with: "Summer street" # Note no street number
      fill_in "City", with: "Boston"
      fill_in "State", with: "MA"
      fill_in "Zip code", with: "12345"
      click_on "Add Location"

      expect(profile.locations.count).to eql(prev_count)
      expect(current_path).to eql(new_trainer_profile_location_path(profile))
      expect(page).to have_content("We couldn't find that address.")
    end

    it "can have more than one location" do
      sign_in(trainer)
      prev_count = profile.locations.count
      visit edit_trainer_profile_path(profile)

      click_on "Add a Location"
      fill_in_location_form(location)
      click_on "Add Location"

      click_on "Add a Location"
      fill_in "Street address", with: "1 Washington Mall"
      fill_in "City", with: "Boston"
      fill_in "State", with: "MA"
      fill_in "Zip code", with: "02108"
      click_on "Add Location"

      expect(profile.locations.count).to eql(prev_count + 2)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content(location[:street_address])
      expect(page).to have_content("1 Washington Mall")
      expect(page).to have_content("Location added.")
    end

  end

  context "unauthorized user" do

    describe "guest user" do

      it "cannot acces the new location page" do
        visit new_trainer_profile_location_path(profile)

        expect(current_path).to eql(new_user_session_path)
        expect(page).to have_content("You need to sign in or sign up")
      end
    end

    describe "member" do
      it "cannot acces the new location page" do
        sign_in(member)
        visit new_trainer_profile_location_path(profile)

        expect(current_path).to eql(root_path)
        expect(page).to have_content("Access denied")
      end
    end

    describe "other trainer" do
      it "cannot acces trainer's new location page" do
        sign_in(other_trainer)
        visit new_trainer_profile_location_path(profile)

        expect(current_path).to eql(root_path)
        expect(page).to have_content("Access denied")
      end
    end
  end


end

def fill_in_location_form(location)
  fill_in "Street address", with: location[:street_address]
  fill_in "City", with: location[:city]
  fill_in "State", with: location[:state]
  fill_in "Zip code", with: location[:zip_code]
end

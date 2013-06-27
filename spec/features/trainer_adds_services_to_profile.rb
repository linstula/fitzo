require 'spec_helper'

feature "Add services to a profile", %{
  As a trainer
  I want to add services to my profile
  So that users can see what services I offer
} do

  # Acceptance Cretieria
  # * I can add services by visiting my edit profile page
  # * must specify a title
  # * must specify a description
  # * must specify a duration
  # * must specify a price
  # * can specify an optional category

  let(:service_attr)  { FactoryGirl.attributes_for(:service) }
  let(:member)        { FactoryGirl.create(:member) }
  let(:trainer)       { FactoryGirl.create(:trainer) }
  let(:profile)       { trainer.trainer_profile }

  context "a registered trainer" do

    it "can add a service with valid attributes" do
      sign_in(trainer)
      prev_count = profile.services.count

      visit new_trainer_profile_service_path(profile)
      fill_in_service_form(service_attr)
      click_on "Create Service"

      expect(profile.services.count).to eql(prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content(service_attr[:title])
    end

    it "cannot add a service with invalid attributes" do
      sign_in(trainer)
      prev_count = profile.services.count

      visit new_trainer_profile_service_path(profile)
      click_on "Create Service"

      expect(page).to have_content "can't be blank"
      expect(page).to have_content "Service was not created. See errors below."
      expect(profile.services.count).to eq prev_count
    end
  end

  context "an unathorized user" do

    let(:other_trainer)  { FactoryGirl.create(:trainer) }

    it "guest user cannot create a sevice for a trainer" do
      visit new_trainer_profile_service_path(profile)
      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end

    it "member cannot create a sevice for a trainer" do
      sign_in(member)

      visit new_trainer_profile_service_path(profile)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
 
    it "other trainer cannot create a sevice for a trainer" do
      sign_in(other_trainer)

      visit new_trainer_profile_service_path(profile)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end
end

require 'spec_helper'

feature "trainer adds a service to their profile", %{
  As a trainer
  I want to add services to my profile
  So that users can see what services I offer
} do

  # Acceptance Cretieria
  # * I can add services by visiting my edit_profile path
  # * must specify a title
  # * must specify a description
  # * must specify a duration
  # * must specify a price
  # * must specify a category

  context "A signed in trainer editing their profile" do

      let(:service_attr)  { FactoryGirl.attributes_for(:service) }
      let(:trainer_attr)  { FactoryGirl.attributes_for(:trainer) }
      let(:new_trainer)   { sign_up_trainer(trainer_attr) }


    it "adds a service with valid attributes" do
      new_trainer
      trainer = User.last
      profile = trainer.trainer_profile
      prev_count = profile.services.count

      visit new_trainer_profile_service_path(profile)
      fill_in_service_form(service_attr)
      click_on "Create Service"

      expect(profile.services.count).to eql(prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content(service_attr[:title])
    end

    it "cannot add a service with invalid attributes" do
      new_trainer
      trainer = User.last
      profile = trainer.trainer_profile
      prev_count = profile.services.count

      visit new_trainer_profile_service_path(profile)
      click_on "Create Service"

      expect(page).to have_content "can't be blank"
      expect(page).to have_content "Service was not created. See errors below."
      expect(profile.services.count).to eq prev_count
    end
  end

  # context "a guest user" do

  #   it "cannot create a sevice for a trainer" do
  #     sign_up_trainer(trainer_attr)
  #     visit new_trainer_profile_service_path(trainer)

  #     expect(current_path).to eql(root_path)
  #     expect(page).to have_content("Access Denied.")
  #   end
  # end

  context "a member" do
  end

  context "another trainer" do
  end
end

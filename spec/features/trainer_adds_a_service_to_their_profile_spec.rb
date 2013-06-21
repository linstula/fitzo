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

  let(:service_attr)   { FactoryGirl.attributes_for(:service) }
  let(:trainer_profile) { FactoryGirl.create(:trainer_profile) }
  let(:trainer)   { trainer_profile.user }

  before(:each) do
    @prev_count = trainer_profile.services.count
    sign_in(trainer)
    visit edit_user_trainer_profile_path(trainer)
    click_on "Add Service"
  end

  it "adds a service with valid attributes" do
    fill_in_service_form(service_attr)
    click_on "Create Service"

    expect(trainer_profile.services.count).to eql(@prev_count + 1)
    expect(current_path).to eql(edit_user_trainer_profile_path(trainer))
    expect(page).to have_content(service_attr[:title])
  end

  it "attempts to add a service with invalid attributes" do
    click_on "Create Service"

    expect(page).to have_content "can't be blank"
    expect(page).to have_content "Service was not created. See errors below."
    expect(trainer_profile.services.count).to eq @prev_count
  end
end

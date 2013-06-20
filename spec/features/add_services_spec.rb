require 'spec_helper'


feature "Trainer services", %{
As a trainer
I want to add services to my profile
so users can see what services I offer
} do

  let(:service_attr)   { FactoryGirl.attributes_for(:service) }
  let(:trainer_profile) { FactoryGirl.create(:trainer_profile) }
  let(:trainer)   { trainer_profile.user }

  it "can be created" do
    sign_in(trainer)
    prev_count = trainer_profile.services.count

    visit edit_user_trainer_profile_path(trainer)

    click_on "Add Service"

    fill_in_service_form(service_attr)
    click_on "Create Service"

    expect(trainer_profile.services.count).to eql(prev_count + 1)
    expect(current_path).to eql(edit_user_trainer_profile_path(trainer))
    expect(page).to have_content(service_attr[:title])
  end

  it "is not created if all required fields are not filled in"

end
# Acceptance Cretieria
# * I can add services by visiting my edit_profile path
# * must specify a title
# * must specify a description
# * must specify a duration
# * must specify a price
# * must specify a category

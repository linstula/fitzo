require 'spec_helper'


feature "Trainer services", %{
As a trainer
I want to add services to my profile
so users can see what services I offer
} do

  let(:trainer)   { FactoryGirl.create(:trainer) }
  let(:service)   { FactoryGirl.create(:service) }

  it "can be created" do
    sign_in(trainer)
    prev_count = trainer.services.count

    visit edit_user_profile_path(trainer)

    click_on "Add Service"

    fill_in_service_form(service)

    expect(trainer.services.count).to eql(prev_count + 1)
    expect(current_path).to eql(edit_user_profile_path(trainer))
    expect(page).to have_content(service.title)
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

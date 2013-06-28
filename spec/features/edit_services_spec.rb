require "spec_helper"

feature "Edit services" do

  let(:trainer) { FactoryGirl.create(:trainer) }
  let(:profile) { trainer.trainer_profile}
  let(:service_attr) { FactoryGirl.attributes_for(:service) }
  
  context "registered trainer" do

    it "can edit a service with valid attributes" do
      prev_count = profile.services.count
      sign_in(trainer)


      profile.services.create(service_attr)
      expect(profile.services.count).to eql(prev_count + 1)

      visit edit_trainer_profile_path(profile)
      click_on "Edit Service"

      fill_in "Title", with: "New service title"
      click_on "Update Service"

      expect(profile.services.count).to eql(prev_count + 1)
      expect(current_path).to eql(edit_trainer_profile_path(profile))
      expect(page).to have_content("New service title")
      expect(page).to have_content("Service updated")
    end
  end

  context "unathorized user"


end

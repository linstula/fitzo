require "spec_helper"

feature "Edit services" do

  let(:trainer)       { FactoryGirl.create(:trainer) }
  let(:profile)       { trainer.trainer_profile}
  let(:service_attr)  { FactoryGirl.attributes_for(:service) }
  let(:member)        { FactoryGirl.create(:member) }
  let(:other_trainer) { FactoryGirl.create(:trainer) }
  
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

    it "does not see edit links on the show page of profile" do
      sign_in(trainer)

      profile.services.create(service_attr)

      visit trainer_profile_path(profile)

      expect(page).to_not have_button("Edit Service")
    end
  end

  context "unathorized user" do

    it "guest user can't access the edit service page" do
      profile.services.create(service_attr)
      service = profile.services.last

      visit edit_trainer_profile_service_path(profile, service)
      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end

    it "member can't access the edit service page" do
      profile.services.create(service_attr)
      service = profile.services.last

      sign_in(member)

      visit edit_trainer_profile_service_path(profile, service)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end

    it "other trainer can't access trainer's edit service page" do
      profile.services.create(service_attr)
      service = profile.services.last

      sign_in(other_trainer)

      visit edit_trainer_profile_service_path(profile, service)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end

  it "needs to create a delete service"

end

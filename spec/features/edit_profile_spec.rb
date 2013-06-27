require "spec_helper"

feature "Edit a profile" do

  context "a registered trainer" do

    it "needs some tests"

  end

  context "an unauthorized user" do

    let(:service_attr)  { FactoryGirl.attributes_for(:service) }
    let(:trainer_attr)  { FactoryGirl.attributes_for(:trainer) }
    let(:new_trainer)   { sign_up_trainer(trainer_attr) }
    let(:member_attr)   { FactoryGirl.attributes_for(:member) }
    let(:new_member)    { sign_up_member(member_attr) }

    it "needs to be refactored"

    it "cannot access the trainer's edit page" do
      new_trainer
      trainer = User.last
      profile = trainer.trainer_profile
      sign_out(trainer)

      visit edit_trainer_profile_path(profile)
      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("You need to sign in or sign up before continuing")

      new_member
      member = User.last

      visit edit_trainer_profile_path(profile)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
      click_on "Sign out"

      new_trainer
      trainer_2 = User.last
      sign_in(trainer_2)

      visit edit_trainer_profile_path(profile)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end


end

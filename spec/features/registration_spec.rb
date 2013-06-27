require 'spec_helper'

feature "User Registration" do

  context "as a member" do

    let(:member) { FactoryGirl.build(:member) }

    it "can create an account" do
      prev_count = User.count
      sign_up_member(member)

      expect(User.count).to eql(prev_count + 1)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end

    it "does not have a profile page" do
      prev_count = TrainerProfile.count
      sign_up_member(member)

      expect(TrainerProfile.count).to eql(prev_count)
    end
  end

  describe "A Trainer signing up" do
    let(:trainer)  { FactoryGirl.build(:trainer) }

    it "can create an account" do
      prev_count = User.count

      visit root_path

      click_on "Get Listed"

      fill_in "Username", with: trainer.username
      fill_in "Email", with: trainer.email
      fill_in "user[password]", with: 12345678
      fill_in "user[password_confirmation]", with: 12345678
      fill_in "First name", with: trainer.first_name
      fill_in "Last name", with: trainer.last_name

      click_on "Submit"

      trainer = User.last

      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(trainer.role).to eql("trainer")
      expect(User.count).to eql(prev_count + 1)
    end

    it "has a profile page created on sign up" do

      prev_count = TrainerProfile.count
      visit root_path

      click_on "Get Listed"

      fill_in "Username", with: trainer.username
      fill_in "Email", with: trainer.email
      fill_in "user[password]", with: 12345678
      fill_in "user[password_confirmation]", with: 12345678
      fill_in "First name", with: trainer.first_name
      fill_in "Last name", with: trainer.last_name

      click_on "Submit"

      expect(TrainerProfile.count).to eql(prev_count + 1)
    end
  end
end

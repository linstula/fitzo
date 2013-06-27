require "spec_helper"

feature "Sign in" do

  context "registered member" do
    
    let!(:registered_member) { FactoryGirl.create(:member) }

    it "can successfully sign in with valid credentials" do
      sign_in(registered_member)

      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_link("Sign out")
    end

    it "cannot sign in if they enter invalid credentials" do
      visit root_path

      click_link "Sign in"

      fill_in "Email", with: "InvalidEmail"
      fill_in "Password", with: "WrongPassword"

      within ".simple_form" do
        click_button "Sign in"
      end

      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("Invalid email or password")
    end
  end

  context "registered trainer" do

    let(:trainer) { FactoryGirl.create(:trainer) }

    it "can successfully sign in with valid credentials" do
      sign_in(trainer)

      click_on "Edit Profile"

      expect(current_path).to eql(edit_trainer_profile_path(trainer.trainer_profile))
    end

    it "cannot sign in if they enter invalid credentials" do
      visit root_path

      click_link "Sign in"

      fill_in "Email", with: "InvalidTrainerEmail"
      fill_in "Password", with: "WrongPassword"

      within ".simple_form" do
        click_button "Sign in"
      end

      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content("Invalid email or password")
    end
  end
end

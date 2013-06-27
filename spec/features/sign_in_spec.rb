require "spec_helper"

feature "Sign in" do

  context "registered member" do
    
    let!(:registered_member) { FactoryGirl.create(:member) }

    it "can sign in if they are a registered user" do
      valid_password = "12345678"
      visit root_path
      click_link "Sign in"

      fill_in "Email", with: registered_member.email
      fill_in "Password", with: valid_password
      within (".simple_form") do
        click_button "Sign in"
      end

      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_link("Sign out")
    end

    scenario "is not signed in if they enter invalid information" do
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

    describe "signed in as a trainer" do
      let(:trainer) { FactoryGirl.create(:trainer) }

      it "can access an edit profile page" do
        trainer.build_trainer_profile.save
        sign_in(trainer)

        click_on "Edit Profile"

        expect(current_path).to eql(edit_trainer_profile_path(trainer.trainer_profile))
      end
    end

    describe "signed in as a user" do

      let(:member) { FactoryGirl.create(:member) }
      let(:trainer) { FactoryGirl.build(:trainer) }

      it "cannot access a trainer's  edit profile page" do
        sign_up(trainer)
        click_on "Sign out"
        new_trainer = User.last
        profile = new_trainer.trainer_profile

        click_on "Sign in"

        fill_in "Email", with: member[:email]
        fill_in "Password", with: 12345678
        click_button "Sign in"

        expect(page).to_not have_link("Edit Profile")
        
        visit edit_trainer_profile_path(profile)
        expect(current_path).to eql(root_path)
        expect(page).to have_content("Access denied")
      end
    end
  end
end

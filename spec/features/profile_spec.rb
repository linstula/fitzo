require 'spec_helper'

feature "A trainer has a profile" do
  
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:trainer)  { FactoryGirl.create(:trainer) }

  describe "signed in trainer" do

    it "has a profile page" do
      sign_in(trainer)
      visit trainer_profile_path(trainer)
      expect(page).to have_content("#{trainer.username.capitalize}'s Profile")
    end

  end

  describe "signed in as a user" do

    # it "does not have a profile page" do
    #   sign_in(user)
    # end

  end

end
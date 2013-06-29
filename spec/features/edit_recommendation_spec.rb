require "spec_helper"

feature "Edit recommendation" do

  let(:recommendation)  { FactoryGirl.create(:recommendation) }
  let(:profile)         { recommendation.trainer_profile }
  let(:member)          { recommendation.user }
  let(:trainer)         { trainer_profile.user }
  
  context "recommendation owner" do

    it "can edit the recommendation with valid attributes" do
      sign_in(member)
      prev_count = profile.recommendations.count

      visit trainer_profile_path(profile)
      click_on "Edit Recommendation"
      fill_in "Title", with: "Edited recommendation title"
      click_on "Update Recommendation"

      expect(profile.recommendations.count).to eql(prev_count)
      expect(current_path).to eql(trainer_profile_path(profile))
      expect(page).to have_content("Recommendation updated.")
      expect(page).to have_content("Edited recommendation title")
    end

    it "cannot edit the recommendation with invalid attributes" do
      sign_in(member)
      prev_count = profile.recommendations.count

      visit trainer_profile_path(profile)
      click_on "Edit Recommendation"
      fill_in "Title", with: ""
      click_on "Update Recommendation"

      expect(profile.recommendations.count).to eql(prev_count)
      expect(current_path).to eql(edit_trainer_profile_recommendation_path(profile,
        recommendation))
      expect(page).to have_content("Recommendation could not be updated.")
    end
  end

  # context "user does not own the recommendation"
  #   it "guest user"
  #   it "other member"
  #   it "trainer"


end

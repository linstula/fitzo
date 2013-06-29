require "spec_helper"

feature "Edit recommendation" do

  let(:recommendation)  { FactoryGirl.create(:recommendation) }
  let(:profile)         { recommendation.trainer_profile }
  let(:member)          { recommendation.user }
  let(:trainer)         { trainer_profile.user }
  
  context "recommendation owner" do

    it "can edit the recommendation" do
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
  end

  # context "user does not own the recommendation"
  #   it "guest user"
  #   it "other member"
  #   it "trainer"


end

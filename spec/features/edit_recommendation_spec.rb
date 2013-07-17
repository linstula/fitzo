require "spec_helper"

feature "Edit recommendation" do

  let(:recommendation)  { FactoryGirl.create(:recommendation) }
  let(:profile)         { recommendation.trainer_profile }
  let(:member)          { recommendation.user }
  let(:trainer)         { profile.user }
  let(:other_member)    { FactoryGirl.create(:member) }
  
  context "recommendation owner" do

    it "can edit the recommendation with valid attributes" do
      sign_in(member)
      prev_count = profile.recommendations.count

      visit trainer_profile_path(profile)
      click_on "Edit"
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
      click_on "Edit"
      fill_in "Title", with: ""
      click_on "Update Recommendation"

      expect(profile.recommendations.count).to eql(prev_count)
      expect(current_path).to eql(edit_trainer_profile_recommendation_path(profile,
        recommendation))
      expect(page).to have_content("Recommendation could not be updated.")
    end

    it "can delete the recommendation" do
      sign_in(member)
      prev_count = profile.recommendations.count

      visit trainer_profile_path(profile)
      click_on "Remove"

      expect(profile.recommendations.count).to eql(prev_count - 1)
      expect(current_path).to eql(trainer_profile_path(profile))
      expect(page).to have_content("Recommendation deleted.")
      expect(page).to_not have_content("Edited recommendation title")
    end
  end

  context "user does not own the recommendation" do

    it "guest user cannot see a delete or edit recommendation button" do
      visit trainer_profile_path(profile)
      expect(profile.recommendations.count).to eql(1)
      expect(page).to_not have_button("Delete Recommendation")
      expect(page).to_not have_button("Edit Recommendation")
    end

    it "guest user cannot access the edit recommendaiton page" do
      visit edit_trainer_profile_recommendation_path(profile, recommendation)
      expect(profile.recommendations.count).to eql(1)
      expect(page).to_not have_button("Edit Recommendation")
    end

    it "other member cannot see a delete or edit recommendation button" do
      sign_in(other_member)
      visit trainer_profile_path(profile)
      expect(profile.recommendations.count).to eql(1)
      expect(page).to_not have_button("Delete Recommendation")
      expect(page).to_not have_button("Edit Recommendation")
    end

    it "other member cannot access the edit recommendaiton page" do
      sign_in(other_member)
      visit edit_trainer_profile_recommendation_path(profile, recommendation)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end

    it "trainer cannot see a delete or edit recommendation button" do
      sign_in(trainer)
      visit trainer_profile_path(profile)
      expect(profile.recommendations.count).to eql(1)
      expect(page).to_not have_button("Delete Recommendation")
      expect(page).to_not have_button("Edit Recommendation")
    end

    it "trainer cannot access the edit recommendaiton page" do
      sign_in(trainer)
      visit edit_trainer_profile_recommendation_path(profile, recommendation)
      expect(current_path).to eql(root_path)
      expect(page).to have_content("Access denied")
    end
  end


end

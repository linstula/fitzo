require "spec_helper"


feature "Write a recommendation" do

  describe "signed in member" do
    
    let(:rec_attr)  { FactoryGirl.attributes_for(:recommendation) }
    let(:trainer)   { FactoryGirl.create(:trainer) }
    let(:profile)   { trainer.trainer_profile } 
    let(:member)    { FactoryGirl.create(:member) }

    it "can write a recommendation with valid attributes" do
      prev_count = profile.recommendations.count

      sign_in(member)
      visit trainer_profile_path(profile)

      fill_in_recommendation(rec_attr)
      click_on "Create Recommendation"

      expect(profile.recommendations.count).to eql(prev_count + 1)
      expect(current_path).to eql(trainer_profile_path(profile))
      expect(page).to have_content(rec_attr[:title])
    end

    it "cannot be created if a user is not signed in" do
      prev_count = profile.recommendations.count
      visit trainer_profile_path(profile)

      fill_in_recommendation(rec_attr)
      click_on "Create Recommendation"

      expect(profile.recommendations.count).to eql(prev_count)
      expect(current_path).to eql(new_user_session_path)
    end

    it "cannot create more than one recommendation per trainer" do
      prev_count = profile.recommendations.count
      sign_in(member)
      visit trainer_profile_path(profile)

      fill_in_recommendation(rec_attr)
      click_on "Create Recommendation"

      expect(profile.recommendations.count).to eql(prev_count + 1)
      current_count = profile.recommendations.count

      rec_attr[:title] = "This is a second recommendation"
      fill_in_recommendation(rec_attr)
      click_on "Create Recommendation"

      expect(profile.recommendations.count).to eql(current_count)
      expect(current_path).to eql(trainer_profile_path(profile))
      expect(page).to_not have_content("This is a second recommendation")
    end

    it "cannot write a recommendation for their own profile" do
      sign_in(trainer)
      visit trainer_profile_path(profile)

      expect(page).to_not have_css("form.new_recommendation")
    end
  end
end

def fill_in_recommendation(recommendation)
  fill_in "Title", with: recommendation[:title]
  fill_in "Content", with: recommendation[:content]
end

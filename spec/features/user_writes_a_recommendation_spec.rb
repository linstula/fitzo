require "spec_helper"

describe "user writes a recommendation for a trainer" do
  
  let(:recommendation_attr)   { FactoryGirl.attributes_for(:recommendation) }
  let(:trainer_profile) { FactoryGirl.create(:trainer_profile) }
  let(:trainer)   { trainer_profile.user }
  let(:member)    { FactoryGirl.create(:member) }

  it "creates a recommendation with valid attributes" do
    prev_count = trainer_profile.recommendations.count
    sign_in(member)
    visit user_trainer_profile_path(trainer)
    click_on "Recommend #{trainer.first_name}"

    fill_in_recommendation_form(recommendation_attr)
    click_on "Submit"

    expect(trainer_profile.recommendations.count).to eql(prev_count + 1)
    expect(current_path).to eql(user_trainer_profile_path(trainer))
    expect(page).to have_content(recommendation[:title])
  end

  it "cannot be created if a user is not signed in"

  it "cannot create more than one recommendation per trainer"

  it "cannot write a recommendation for their own profile"
end

def fill_in_recommendation_form(recommendation)
  fill_in "Title", with: recommendation[:title]
  fill_in "Write Your Recommendation:", with: recommendation[:content]
end

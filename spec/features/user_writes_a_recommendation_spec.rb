require "spec_helper"

describe "user writes a recommendation for a trainer" do
  
  let(:recommendation_attr)   { FactoryGirl.build(:recommendation) }
  let(:trainer)   { FactoryGirl.create(:trainer) } 
  let(:member)    { FactoryGirl.create(:member) }

  it "creates a recommendation with valid attributes" do
    profile = trainer.trainer_profile
    prev_count = profile.recommendations.count
    sign_in(member)
    visit user_trainer_profile_path(trainer)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count + 1)
    expect(current_path).to eql(user_trainer_profile_path(trainer))
    expect(page).to have_content(recommendation_attr[:title])
  end

  it "cannot be created if a user is not signed in" do
    profile = trainer.trainer_profile
    prev_count = profile.recommendations.count
    visit user_trainer_profile_path(trainer)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count)
    expect(current_path).to eql(new_user_session_path)
  end

  it "cannot create more than one recommendation per trainer" do
    profile = trainer.trainer_profile
    prev_count = profile.recommendations.count
    sign_in(member)
    visit user_trainer_profile_path(trainer)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count + 1)
    current_count = profile.recommendations.count

    recommendation_attr.title= "This is a second recommendation"
    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(current_count)
    expect(current_path).to eql(user_trainer_profile_path(trainer))
    expect(page).to_not have_content("This is a second recommendation")
  end

  it "should tell a user that they have already recommended a trainer"

  it "cannot write a recommendation for their own profile" 

  it "cannot write a recommendation if they are a trainer"
end

def fill_in_recommendation(recommendation)
  fill_in "Title", with: recommendation[:title]
  fill_in "Content", with: recommendation[:content]
end

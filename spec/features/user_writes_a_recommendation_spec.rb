require "spec_helper"

describe "user writes a recommendation for a trainer" do
  
  let(:recommendation_attr)   { FactoryGirl.build(:recommendation) }
  let(:trainer)   { FactoryGirl.build(:trainer) } 
  let(:member)    { FactoryGirl.create(:member) }

  before(:each) do
    
  end

  it "creates a recommendation with valid attributes" do
    sign_up(trainer)
    new_trainer = User.last
    profile = new_trainer.trainer_profile
    prev_count = profile.recommendations.count
    click_on "Sign out"

    sign_in(member)
    visit trainer_profile_path(new_trainer.trainer_profile)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count + 1)
    expect(current_path).to eql(trainer_profile_path(profile))
    expect(page).to have_content(recommendation_attr[:title])
  end

  it "cannot be created if a user is not signed in" do
    sign_up(trainer)
    new_trainer = User.last
    profile = new_trainer.trainer_profile
    click_on "Sign out"

    profile = new_trainer.trainer_profile
    prev_count = profile.recommendations.count
    visit trainer_profile_path(profile)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count)
    expect(current_path).to eql(new_user_session_path)
  end

  it "cannot create more than one recommendation per trainer" do
    sign_up(trainer)
    new_trainer = User.last
    click_on "Sign out"

    profile = new_trainer.trainer_profile
    prev_count = profile.recommendations.count
    sign_in(member)
    visit trainer_profile_path(profile)

    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(prev_count + 1)
    current_count = profile.recommendations.count

    recommendation_attr.title= "This is a second recommendation"
    fill_in_recommendation(recommendation_attr)
    click_on "Create Recommendation"

    expect(profile.recommendations.count).to eql(current_count)
    expect(current_path).to eql(trainer_profile_path(profile))
    expect(page).to_not have_content("This is a second recommendation")
  end

  it "cannot write a recommendation for their own profile" 

  it "cannot write a recommendation if they are a trainer"
end

def fill_in_recommendation(recommendation)
  fill_in "Title", with: recommendation[:title]
  fill_in "Content", with: recommendation[:content]
end

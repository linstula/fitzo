require 'spec_helper'

describe Specialty do

  it { should have_many(:trainer_profiles) }
  it { should have_many(:trainer_specialties).dependent(:destroy)}
  it { should have_many(:trainer_specialties) }

  it { should have_valid(:title).when("Title")}

  it { should_not have_valid(:title).when("", nil)}

  it "touches associated trainer profiles after being updated" do
  	specialty = FactoryGirl.create(:specialty)
  	specialty.trainer_profiles << FactoryGirl.create(:trainer_profile)
  	profile = specialty.trainer_profiles.first

  	expect(profile.specialties.count).to eql(1)
  	last_update = profile.updated_at

  	specialty.title = "New Spec Title"
  	specialty.save

  	expect(profile.updated_at).to_not eql(last_update)
  end

end

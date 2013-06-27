require 'spec_helper'

describe Recommendation do
  
  it { should belong_to(:trainer_profile) }
  it { should belong_to(:user) }

  it { should have_valid(:title).when("Title")}
  it { should have_valid(:content).when("This is content")}

  it { should_not have_valid(:title).when("", nil)}
  it { should_not have_valid(:content).when("", nil)}


  it "validates unqiueness of the user_id and trainer_profile_id" do
    rec = Recommendation.create(title: "Title", content: "Content",
      user_id: 1, trainer_profile_id: 1)

    rec_2 = Recommendation.create(title: "Title2", content: "Content2",
      user_id: 1, trainer_profile_id: 1)

    expect(rec_2).to_not be_valid
  end
end

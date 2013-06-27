require 'spec_helper'

describe Recommendation do
  
  it { should belong_to(:trainer_profile) }
  it { should belong_to(:user) }

  it { should have_valid(:title).when("Title")}
  it { should have_valid(:content).when("This is content")}

  it { should_not have_valid(:title).when("", nil)}
  it { should_not have_valid(:content).when("", nil)}


  it "validates unqiueness of the user_id and trainer_profile_id" do
    trainer = FactoryGirl.create(:trainer)
    profile = trainer.build_trainer_profile
    profile.save
    member = FactoryGirl.create(:member)

    rec = Recommendation.create(title: "Title", content: "Content",
      user_id: member.id, trainer_profile_id: profile.id)

    rec_2 = Recommendation.new(title: "Title2", content: "Content2",
      user_id: member.id, trainer_profile_id: profile.id)
    
    expect(rec).to be_valid
    expect(rec_2).to_not be_valid
  end

  it "cannot be created for a trainer's own profile" do
    trainer = FactoryGirl.create(:trainer)
    profile = trainer.build_trainer_profile
    profile.save
    member = FactoryGirl.create(:member)


    rec = Recommendation.new(title: "Title", content: "Content",
      user_id: trainer.id, trainer_profile_id: profile.id)

    rec_2 = Recommendation.new(title: "Title2", content: "Content2",
      user_id: (member.id) , trainer_profile_id: (profile.id))

    expect(rec).to_not be_valid
    expect(rec_2).to be_valid
  end
end

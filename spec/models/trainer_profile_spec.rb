require 'spec_helper'

describe TrainerProfile do

  it { should belong_to(:user) }
  it { should have_many(:services).dependent(:destroy) }
  it { should have_many(:specialties) }
  it { should have_many(:trainer_specialties).dependent(:destroy) }
  it { should have_many(:recommendations).dependent(:destroy) }

  it { should validate_presence_of(:user_id)}

  it "should be able to add new specialties" do
    spec    = Specialty.create(title: "First Specialty")
    spec_2  = Specialty.create(title: "Second Specialty")
    trainer = FactoryGirl.create(:trainer)
    profile = trainer.build_trainer_profile
    profile.save
    spec_ids = [spec.id, spec_2.id]
    prev_count = profile.trainer_specialties.count

    profile.add_specialties(spec_ids)
    expect(profile.trainer_specialties.count).to eql(prev_count + 2)
  end

  it "should be able to remove specialties" do
    spec    = Specialty.create(title: "First Specialty")
    spec_2  = Specialty.create(title: "Second Specialty")
    trainer = FactoryGirl.create(:trainer)
    profile = trainer.build_trainer_profile
    profile.save
    spec_ids = [spec.id.to_s, spec_2.id.to_s]
    prev_count = profile.trainer_specialties.count

    profile.add_specialties(spec_ids)
    current_count = profile.trainer_specialties.count

    updated_spec_ids = [spec.id.to_s]
    profile.remove_specialties(updated_spec_ids)
    expect(profile.trainer_specialties.count).to eql(current_count - 1)
  end
end

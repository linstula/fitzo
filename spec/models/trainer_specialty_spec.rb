require 'spec_helper'

describe TrainerSpecialty do

  it { should belong_to(:trainer_profile) }
  it { should belong_to(:specialty) }

  it { should validate_presence_of(:trainer_profile_id)}
  it { should validate_presence_of(:specialty_id)}

  it "validates unqiness of specialties for a trainer profile" do
    trainer_specialty_1 = TrainerSpecialty.create(trainer_profile_id: 1, specialty_id: 1)
    trainer_specialty_2 = TrainerSpecialty.create(trainer_profile_id: 1, specialty_id: 1)

    expect(trainer_specialty_1).to be_valid
    expect(trainer_specialty_2).to_not be_valid
  end
end

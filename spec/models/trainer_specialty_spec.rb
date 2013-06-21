require 'spec_helper'

describe TrainerSpecialty do

  it { should belong_to(:trainer_profile) }
  it { should belong_to(:specialty) }

  it { should validate_presence_of(:trainer_profile_id)}
  it { should validate_presence_of(:specialty_id)}





end

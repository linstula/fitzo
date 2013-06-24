require 'spec_helper'

describe TrainerProfile do

  it { should belong_to(:user) }
  it { should have_many(:services).dependent(:destroy) }
  it { should have_many(:specialties) }
  it { should have_many(:trainer_specialties).dependent(:destroy) }
  it { should have_many(:recommendations).dependent(:destroy) }


  it { should validate_presence_of(:user_id)}
end

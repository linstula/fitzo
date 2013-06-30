require 'spec_helper'

describe TrainerLocation do

  it { should belong_to(:trainer_profile) }
  it { should belong_to(:location) }

  it { should validate_presence_of(:trainer_profile_id) }
  it { should validate_presence_of(:location_id) }

end

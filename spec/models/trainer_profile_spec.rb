require 'spec_helper'

describe TrainerProfile do

  it { should belong_to(:user) }
  it { should have_many(:services).dependent(:destroy) }

  it { should validate_presence_of(:user_id)}
end

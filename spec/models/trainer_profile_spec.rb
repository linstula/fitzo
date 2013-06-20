require 'spec_helper'

describe TrainerProfile do

  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id)}
  it { should have_many(:services) }


  describe "services" do
    it "should be destroyed when the profile is deleted"
  end
end

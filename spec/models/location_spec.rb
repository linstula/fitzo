require 'spec_helper'

describe Location do
  
  it { should have_many(:trainer_locations) }
  it { should have_many(:trainer_profiles) }
  
  it { should have_valid(:street_address).when("123 ABC street") }
  it { should have_valid(:city).when("SomeCity") }
  it { should have_valid(:state).when("AK", "MA") }

  it { should_not have_valid(:street_address).when(nil, "", "   ") }
  it { should_not have_valid(:city).when(nil, "", "   ") }
  it { should_not have_valid(:state).when(nil, "", "  ", "Alaska",
    "Massachusetts") }

  it "need test coverage for location model methods"
end

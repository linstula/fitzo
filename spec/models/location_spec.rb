require 'spec_helper'

describe Location do
  
  it { should have_many(:trainer_locations) }
  it { should have_many(:trainer_profiles) }
  
  it { should have_valid(:street_address).when("123 ABC street") }
  it { should have_valid(:city).when("SomeCity") }
  it { should have_valid(:state).when("AK", "MA") }
  it { should have_valid(:zip_code).when("92211".to_i) }

  it { should_not have_valid(:street_address).when(nil, "", "   ") }
  it { should_not have_valid(:city).when(nil, "", "   ") }
  it { should_not have_valid(:state).when(nil, "", "  ", "Alaska", "Massachusetts") }
  it { should_not have_valid(:zip_code).when(nil, "", "   ", "1234".to_i, "string") }

  it "should validate the get_location_details method"
end

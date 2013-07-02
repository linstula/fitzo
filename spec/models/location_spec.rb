require 'spec_helper'

describe Location, :vcr do
  
  it { should have_many(:trainer_locations) }
  it { should have_many(:trainer_profiles) }
  it { should have_many(:specialties) }
  
  it { should have_valid(:street_address).when("123 ABC street") }
  it { should have_valid(:city).when("SomeCity") }
  it { should have_valid(:state).when("MA") }
  it { should have_valid(:zip_code).when("99603")}

  it { should_not have_valid(:street_address).when(nil, "", "   ") }
  it { should_not have_valid(:city).when(nil, "", "   ") }
  it { should_not have_valid(:state).when(nil, "", "  ", "Alaska",
    "Massachusetts") }
  it { should_not have_valid(:zip_code).when(nil, "", "   ",
    "non-integer string", "1234", "123456") }


  it "can create a full_address" do
    loc = FactoryGirl.build(:location)
    loc.make_full_address
    expect(loc.full_address).to eql("337 Summer Street Boston, MA 02210")
  end

  it "can see if the location has already been registered" do
    loc = FactoryGirl.build(:location)
    expect(loc.already_registered?).to be false
    loc.definitive_result?
    loc.save

    loc_2 = FactoryGirl.build(:location)
    loc_2.make_full_address
    expect(loc_2.already_registered?).to be true
  end

  it "can query the gmaps API and determine whether it returned a definitive result" do
    loc = FactoryGirl.build(:location)
    loc.make_full_address
    loc.query_location_data
    expect(loc.definitive_result?).to be true

    loc_2 = Location.new(street_address: "123", city: "SOMETHING",
      state: "MA", zip_code: "12345" )
    loc_2.make_full_address
    loc_2.query_location_data
    expect(loc_2.definitive_result?).to be false
  end

  it "assigns lat/long coordiantes and a neighborhood if available" do
    loc = FactoryGirl.build(:location)
    loc.already_registered?
    loc.definitive_result?
    loc.save

    expect(loc.latitude).to be_kind_of(Float)
    expect(loc.longitude).to be_kind_of(Float)
    expect(loc.neighborhood).to eql("Fort Point")
  end

  it "can be searched for with :street_address, :neighborhood, and :zip_code" do
    loc = Location.new(street_address: "337 Summer Street", city: "Boston",
      state: "MA", zip_code: "02210")
    loc.already_registered?
    loc.definitive_result?
    loc.save

    loc_2 = Location.new(street_address: "1 Washington Street", city: "Boston",
      state: "MA", zip_code: "02108")
    loc_2.already_registered?
    loc_2.definitive_result?
    loc_2.save

    search_results = Location.search_for_locations("337 Summer Street")
    expect(search_results.include?(loc)).to be true 
    expect(search_results.include?(loc_2)).to be false
  end
  it "can be searched for through specialties associations by :title"
end

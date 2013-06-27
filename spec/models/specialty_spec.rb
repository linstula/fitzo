require 'spec_helper'

describe Specialty do
  
  it { should have_many(:trainer_profiles) }
  it { should have_many(:trainer_specialties).dependent(:destroy)}
  it { should have_many(:trainer_specialties) }

  it { should have_valid(:title).when("Title")}

  it { should_not have_valid(:title).when("", nil)}

  it "should have a better controller for admin use"

end

require 'spec_helper'

describe Service do

  it { should belong_to(:trainer_profile) }
  
  it { should have_valid(:title).when("Title")}
  it { should have_valid(:description).when("A Description")}
  it { should have_valid(:duration).when("1 hour", "100 minutes")}
  it { should have_valid(:price).when(1, 100)}
  it { should have_valid(:trainer_profile_id).when(1, 100)}

  it { should have_valid(:category).when("A Category", "", nil)}

  it { should_not have_valid(:title).when("", nil)}
  it { should_not have_valid(:description).when("", nil)}
  it { should_not have_valid(:duration).when("", nil)}
  it { should_not have_valid(:price).when("string", "", nil, 1.0, 0.99, 100.0)}
  it { should_not have_valid(:trainer_profile_id).when("", nil)}

end

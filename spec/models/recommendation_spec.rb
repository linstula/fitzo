require 'spec_helper'

describe Recommendation do
  
  it { should belong_to(:trainer_profile) }
  it { should belong_to(:user) }

  it { should have_valid(:title).when("Title")}
  it { should have_valid(:content).when("This is content")}

  it { should_not have_valid(:title).when("", nil)}
  it { should_not have_valid(:content).when("", nil)}

end

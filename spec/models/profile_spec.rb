require 'spec_helper'

describe Profile do

  it { should belong_to(:user) }

  # let(:user)     { FactoryGirl.create(:user) }
  # let(:trainer)  { FactoryGirl.create(:trainer) }

  # it "creates an associated profile" do
  #   new_trainer = trainer

  # end

end
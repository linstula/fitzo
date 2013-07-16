require 'spec_helper'

describe User do

  let(:member) { FactoryGirl.build(:member) }
  let(:trainer) { FactoryGirl.build(:trainer) }

  it { should have_valid(:email).when("foobar@example.com") }
  it { should have_valid(:password).when("foobarbaz") }
  it { should have_valid(:username).when("foousername") }
  it { should have_valid(:first_name).when("Firstname") }
  it { should have_valid(:last_name).when("Lastname") }
  it { should have_valid(:role).when("member", "trainer") }


  it { should_not have_valid(:email).when(nil, "", "foobar@example") }
  it { should_not have_valid(:password).when(nil, "", 1234567) }
  it { should_not have_valid(:username).when(nil, "") }
  it { should_not have_valid(:first_name).when(nil, "") }
  it { should_not have_valid(:last_name).when(nil, "") }
  it { should_not have_valid(:role).when(nil, "", "not_user", "not_trainer") }

  it { should have_one(:trainer_profile).dependent(:destroy) }
  it { should have_many(:recommendations).dependent(:destroy) }


  describe "profile" do
    it "has a profile if the role is 'trainer'" do
      trainer.save
      trainer.build_trainer_profile.save
      expect(trainer.trainer_profile).to be_valid
    end

    it "does not have a profile if the role is 'member'" do
      member.save
      expect(member.trainer_profile).to be nil
    end
  end
end

require 'spec_helper'

describe User do

  it { should have_valid(:email).when("foobar@example.com") }
  it { should have_valid(:password).when("foobarbaz") }
  it { should have_valid(:username).when("foousername") }
  it { should have_valid(:first_name).when("Firstname") }
  it { should have_valid(:last_name).when("Lastname") }

  it { should_not have_valid(:email).when(nil, "", "foobar@example") }
  it { should_not have_valid(:password).when(nil, "", 1234567) }
  it { should_not have_valid(:username).when(nil, "") }
  it { should_not have_valid(:first_name).when(nil, "") }
  it { should_not have_valid(:last_name).when(nil, "") }

  
end

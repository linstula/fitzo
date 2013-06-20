require 'spec_helper'

feature "A Member signing up" do

  let(:member) { FactoryGirl.build(:member) }

  it "can create an account" do
    prev_count = User.count
    visit root_path

    click_button "Sign up"

    sign_up(member)


    expect(User.count).to eql(prev_count + 1)
    expect(current_path).to eql(root_path)
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  it "does not have a profile page" do
    prev_count = TrainerProfile.count
    visit root_path

    click_button "Sign up"

    sign_up(member)

    expect(TrainerProfile.count).to eql(prev_count)
    visit user_trainer_profile_path("#{User.last.id}")
    expect(current_path).to eql(root_path)
    expect(page).to have_content("Resource does not exist")
  end



end

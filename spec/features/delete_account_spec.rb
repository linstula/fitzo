require "spec_helper"

feature "Delete account" do

  let(:member) { FactoryGirl.create(:member) }

  it "when I'm signed in" do
    sign_in(member)
    prev_count = User.count

    visit edit_user_registration_path
    click_on "Cancel my account"

    expect(User.count).to eql(prev_count - 1)
    expect(page).to have_content("Bye! Your account was 
      successfully cancelled. We hope to see you again soon.")
  end

  it "when I'm not signed in" do 
    prev_count = User.count

    visit edit_user_registration_path

    expect(current_path).to eql(new_user_session_path)
    expect(User.count).to eql(prev_count)
  end
end

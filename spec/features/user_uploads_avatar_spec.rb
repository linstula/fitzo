require "spec_helper"

feature "User uploads avatar" do

  let(:member) { FactoryGirl.create(:member) }
  
  it "can upload an image for an avatar" do
    sign_in(member)

    visit edit_user_registration_path(member)

    fill_in "user[current_password]", with: "12345678"
    attach_file('user_avatar', "#{Rails.root}/spec/images/test.jpg")    
    click_on "Update"
    expect(member.avatar).to_not be nil

    visit edit_user_registration_path(member)

    expect("/uploads/user/avatar/" + member.id.to_s + "/test.jpg").to be_present
  end

end

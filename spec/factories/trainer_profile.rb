FactoryGirl.define do
  factory :trainer_profile do
    phone_number "1234567890"
    website "example.com"
    about "This is some text about me"
    association :user, factory: :trainer
  end
end

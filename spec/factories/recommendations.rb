# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    sequence(:title) {|n| "This is recommendation title #{n}" }
    content "This is the content for a recommendation."
    association :user, factory: :member
    trainer_profile
  end
end

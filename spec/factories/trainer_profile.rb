FactoryGirl.define do
  factory :trainer_profile do
    association :user, factory: :trainer
  end
end

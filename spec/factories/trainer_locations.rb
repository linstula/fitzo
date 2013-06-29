# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trainer_location, :class => 'TrainerLocations' do
    trainer_profile_id 1
    location_id 1
  end
end

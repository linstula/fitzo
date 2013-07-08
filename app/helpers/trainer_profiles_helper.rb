module TrainerProfilesHelper
  def get_profiles(locations)
    profiles = []
    locations.each do |location|
      profiles << location.trainer_profile unless profiles.include?(location.trainer_profile)
    end
    profiles
  end

  def locations_list(trainer_profile)
    locations = []
    trainer_profile.locations.each do |location|
      locations << location.full_address
    end
    locations
  end
end

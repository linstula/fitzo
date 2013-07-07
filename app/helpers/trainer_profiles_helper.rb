module TrainerProfilesHelper
  def get_profiles(locations)
    profiles = []
    locations.each do |location|
      location.trainer_profiles.each do |profile|
        profiles << profile unless profiles.include?(profile)
      end
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

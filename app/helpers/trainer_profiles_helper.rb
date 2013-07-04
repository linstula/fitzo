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
end

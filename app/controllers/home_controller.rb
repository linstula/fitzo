class HomeController < ApplicationController

  def show
    @trainer_profiles = TrainerProfile.search_for_profiles(params[:query])
    @trainer_locations = []
    @trainer_profiles.each do |profile|
      profile.locations.each do |location|
        @trainer_locations << location
      end
    end
    @json = @trainer_locations.to_gmaps4rails
  end
end

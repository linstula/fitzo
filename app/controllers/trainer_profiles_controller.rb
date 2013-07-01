class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def index
    @trainer_profiles = TrainerProfile.search_for_profiles(params[:query])
    @trainer_locations = []
    @trainer_profiles.each do |profile|
      profile.locations.each do |location|
        @trainer_locations << location
      end
    end
    @json = @trainer_locations.to_gmaps4rails  
  end

  def show
    @recommendation = Recommendation.new(trainer_profile_id: @trainer_profile.id)
  end

  def edit
    @trainer_specialties = @trainer_profile.trainer_specialties.build
    authorize! :manage, @trainer_profile
  end

  def update
    @specialties = params[:trainer_profile][:specialty_ids].reject! { |c| c.empty? }

    @trainer_profile.update_specialties(@specialties)

    redirect_to edit_trainer_profile_path(@trainer_profile),
      notice: "Profile updated"
  end
end

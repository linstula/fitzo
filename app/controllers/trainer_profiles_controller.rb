class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def index
    # The search_for_locations method returns a two dimensional array
    @locations = Location.search_for_locations(params[:query])

    # get_profiles returns all the trainer profiles from the locations
    # and returns them as a single dimensional array with unique elements
    profile_results = view_context.get_profiles(@locations)

    @profiles = Kaminari.paginate_array(profile_results).page(params[:page])

    @json = @locations.to_gmaps4rails  
  end

  def show
    current_user ||= User.new
    @recommendation = current_user.recommendations.build
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

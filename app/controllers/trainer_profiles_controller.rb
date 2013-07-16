class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def index
    # The search_for_locations method returns a two dimensional array
    @locations = Location.search_for_locations(params[:query]).includes(trainer_profile: [:user, :specialties, :locations])

    # get_profiles returns all the trainer profiles from the locations
    # and returns them as a single dimensional array with unique elements
    profile_search_results = view_context.get_profiles(@locations)

    @profiles = Kaminari.paginate_array(profile_search_results).page(params[:page])

    @json = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(:partial => "/locations/info_window",
        :locals => { :location => location})
    end 
  end

  def show
    current_user ||= User.new
    @locations = @trainer_profile.locations
    @json = @locations.to_gmaps4rails
    @recommendation = current_user.recommendations.build
  end

  def edit
    @json = @trainer_profile.locations.to_gmaps4rails
    @trainer_specialties = @trainer_profile.trainer_specialties.build
    authorize! :manage, @trainer_profile
  end

  def update
    if params[:trainer_profile][:specialty_ids].present?
      @specialties = params[:trainer_profile][:specialty_ids].
        reject! { |c| c.empty? }
      @trainer_profile.update_specialties(@specialties)
      redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Specialties updated"
    else
      if @trainer_profile.update_attributes(params[:trainer_profile])
        redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Profile updated"
      else
        redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Profile could not be updated"
      end
    end
  end
end

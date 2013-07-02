class LocationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  load_and_authorize_resource :trainer_profile

  def new
    # @trainer_profile = current_user.trainer_profile
    # @location = Location.new
    if current_user.id != @trainer_profile.user.id
      redirect_to root_path, notice: "Access denied"
    end
  end

  def create
    # @trainer_profile = current_user.trainer_profile
    # @location = @trainer_profile.locations.build(params[:location])

    unless @location.already_registered?
      if @location.definitive_result?
        if @location.save
          TrainerLocation.create(trainer_profile_id: @trainer_profile.id,
            location_id: @location.id)

          redirect_to edit_trainer_profile_path(@trainer_profile),
            notice: "Location added."
        else
          redirect_to new_trainer_profile_location_path(@trainer_profile),
            notice: "Location could not be added."
        end
      else
        redirect_to new_trainer_profile_location_path(@trainer_profile),
            notice: "We couldn't find that address."
      end
    else
      TrainerLocation.create(trainer_profile_id: @trainer_profile.id,
        location_id: @location)

      redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Location added."
    end
  end
end
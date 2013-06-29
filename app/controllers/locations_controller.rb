class LocationsController < ApplicationController

  def new
    @trainer_profile = current_user.trainer_profile
    @location = Location.new
  end

  def create
    @trainer_profile = current_user.trainer_profile
    @location = @trainer_profile.locations.build(params[:location])

    unless @location.already_registered?
      if @location.save
        TrainerLocation.create(trainer_profile_id: @trainer_profile.id,
          location_id: @location.id)

        redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Location added."
      else
        flash[:now] = "Location could not be added."
        render "new"
      end
    else
      TrainerLocation.create(trainer_profile_id: @trainer_profile.id,
        location_id: @location)

      redirect_to edit_trainer_profile_path(@trainer_profile),
          notice: "Location added."
    end
  end
end

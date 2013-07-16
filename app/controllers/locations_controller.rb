class LocationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :trainer_profile
  load_and_authorize_resource :location, through: :trainer_profile

  def new
    if current_user.id != @trainer_profile.user.id
      redirect_to root_path, notice: "Access denied"
    end
  end

  def create
    @location = @trainer_profile.locations.build(params[:location])
    
    if @location.definitive_result?
      if @location.save
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
  end

  def destroy
    @trainer_profile = current_user.trainer_profile
    if @location.destroy
      redirect_to edit_trainer_profile_path(@trainer_profile),
        notice: "Location removed"
    else
      redirect_to edit_trainer_profile_path(@trainer_profile),
        notice: "Location could not be removed removed"
    end
  end
end

class SpecialtiesController < ApplicationController

  def new
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @user = @trainer_profile.user
    @specialty = @trainer_profile.specialties.build
  end

  def create
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @user = @trainer_profile.user
    @specialty = @trainer_profile.specialties.build(params[:specialty])
    
    if @specialty.save
      flash[:notice] = "Service added."
      redirect_to edit_user_trainer_profile_path(@user)
    else
      flash.now[:notice] = "Service was not added. See errors below."
      render "new"
    end
  end
end

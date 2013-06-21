class ServicesController < ApplicationController

  def new
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @user = @trainer_profile.user
    @service = @trainer_profile.services.build
  end

  def create
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @user = @trainer_profile.user
    @service = @trainer_profile.services.build(params[:service])
    
    if @service.save
      redirect_to edit_user_trainer_profile_path(@user)
      flash.now[:notice] = "Service added."
    else
      flash.now[:notice] = "Service was not created. See errors below."
      render 'new'
    end
  end
end

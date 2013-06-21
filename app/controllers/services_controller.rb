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
    else
      flash.now[:notice] = "That was silly..."
      render 'new'
    end
  end
end

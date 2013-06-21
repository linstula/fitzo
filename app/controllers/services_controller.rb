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
      render 'new', notice: "That was silly..."
    end
  end
end

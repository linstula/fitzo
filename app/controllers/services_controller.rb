class ServicesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @trainer_profile = current_user.trainer_profile ||= TrainerProfile.new
    @service = @trainer_profile.services.build 
    authorize! :manage, @trainer_profile
  end

  def create
    @trainer_profile = current_user.trainer_profile
    @service = @trainer_profile.services.build(params[:service])
    
    if @service.save
      redirect_to edit_trainer_profile_path(@trainer_profile)
      flash.now[:notice] = "Service added."
    else
      flash.now[:notice] = "Service was not created. See errors below."
      render 'new'
    end
  end
end

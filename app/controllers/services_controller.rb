class ServicesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :trainer_profile
  load_and_authorize_resource :service, through: :trainer_profile

  def new
    if current_user.trainer_profile
      @trainer_profile = current_user.trainer_profile
      @service = @trainer_profile.services.build
    else
      redirect_to root_path
    end 
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

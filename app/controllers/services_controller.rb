class ServicesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :trainer_profile
  load_and_authorize_resource :service, through: :trainer_profile

  def new
  end

  def create
    if @service.save
      redirect_to edit_trainer_profile_path(@trainer_profile), 
        notice: "Service added."
    else
      flash.now[:notice] = "Service was not created. See errors below."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @service.update_attributes(params[:service])
      redirect_to edit_trainer_profile_path(@trainer_profile),
        notice: "Service updated."
    else
      flash[:now] = "Unable to update service."
      render "edit"
    end
  end

  def destroy
    if @service.destroy
      redirect_to edit_trainer_profile_path(@trainer_profile),
        notice: "Service removed."
    else
      redirect_to edit_trainer_profile_path(@trainer_profile),
        notice: "Unable to remove service."
    end
  end
end

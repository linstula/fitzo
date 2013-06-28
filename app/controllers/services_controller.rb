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
      flash[:now] = "Service not updated."
      render "edit"
    end
  end
end

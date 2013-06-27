class SpecialtiesController < ApplicationController

  def new
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @trainer = @trainer_profile.user
    @specialty = @trainer_profile.specialties.build
    @specialties = Specialty.all
  end

  def create
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @specialty = @trainer_profile.specialties.build(params[:specialty])
    @user = @trainer_profile.user
    
    
    if @specialty.save
      TrainerSpecialty.create(trainer_profile_id: @trainer_profile.id,
        specialty_id: @specialty.id)
      flash[:notice] = "Specialty added."
      redirect_to edit_trainer_profile_path(@trainer_profile)
    else
      flash.now[:notice] = "Specialty was not added. See errors below."
      render "new"
    end
  end
end

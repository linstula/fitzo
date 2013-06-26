class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  def show
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer = @trainer_profile.user
    @recommendation = Recommendation.new

    unless @trainer.role == "trainer"
      redirect_to root_path, notice: "Resource does not exist"
    end
  end

  def edit
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer_specialties = @trainer_profile.trainer_specialties.build
    if @trainer_profile.owner?(current_user)
      @trainer = @trainer_profile.user
    else
      redirect_to root_path, notice: "Resource does not exist"
    end
  end

  def update
    @trainer_profile = TrainerProfile.find(params[:id])
    @specialties = params[:trainer_profile][:specialty_ids]
    @specialties.each do |specialty_id|
      unless specialty_id.blank?
        specialty = @trainer_profile.trainer_specialties.build(specialty_id: specialty_id)
        specialty.save
      end
    end
    redirect_to edit_trainer_profile_path(@trainer_profile),
      notice: "Profile updated"
  end

end

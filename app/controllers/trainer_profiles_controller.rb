class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]

  def show
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer = @trainer_profile.user
    @recommendation = Recommendation.new
  end

  def edit
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer_specialties = @trainer_profile.trainer_specialties.build
    authorize! :manage, @trainer_profile
  end

  def update
    @trainer_profile = TrainerProfile.find(params[:id])
    @specialties = params[:trainer_profile][:specialty_ids]

    @trainer_profile.update_specialties(@specialties)

    redirect_to edit_trainer_profile_path(@trainer_profile),
      notice: "Profile updated"
  end
end

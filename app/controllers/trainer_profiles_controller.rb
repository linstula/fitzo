class TrainerProfilesController < ApplicationController

  def show
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer = @trainer_profile.user
    @recommendation = Recommendation.new
  end

  def edit
    @trainer_profile = TrainerProfile.find(params[:id])
    authorize! :edit, @trainer_profile
  end
end

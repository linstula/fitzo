class TrainerProfilesController < ApplicationController

  def show
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer = @trainer_profile.user
    @recommendation = Recommendation.new
  end

  def edit
    if user_signed_in?
      @trainer_profile = TrainerProfile.find(params[:id])
      authorize! :edit, @trainer_profile
    else
      redirect_to new_user_session_path, notice: "You must be signed in"
    end
  end
end

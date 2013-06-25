class RecommendationsController < ApplicationController

  def create
    if user_signed_in?
      @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
      @recommendation = @trainer_profile.recommendations.build(params[:recommendation])
      @recommendation.user = current_user

      if @recommendation.save
        redirect_to trainer_profile_path(@trainer_profile),
          notice: "Recommendation added"
      else
        redirect_to trainer_profile_path(@trainer_profile), 
          notice: "Recommendation was not added."
      end
    else
      redirect_to new_user_session_path,
        notice: "You must sign in to write a recommendaiton"
    end
  end
end

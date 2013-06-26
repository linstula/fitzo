class RecommendationsController < ApplicationController
  before_filter :authenticate_user!
  def create
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
  end
end

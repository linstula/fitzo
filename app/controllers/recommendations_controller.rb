class RecommendationsController < ApplicationController
  before_filter :authenticate_user!
  # load_and_authorize_resource :user
  # load_and_authorize_resource :recommendation, through: :user
  def create
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @recommendation = @trainer_profile.recommendations.build(params[:recommendation])
    @recommendation.user = current_user

    if @recommendation.save
      redirect_to trainer_profile_path(@trainer_profile),
        notice: "Recommendation added."
    else
      redirect_to trainer_profile_path(@trainer_profile), 
        notice: "Recommendation could not be added."
    end
  end

  def edit
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @trainer_profile = TrainerProfile.find(params[:trainer_profile_id])
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update_attributes(params[:recommendation])
      redirect_to trainer_profile_path(@trainer_profile),
        notice: "Recommendation updated."
    else
      redirect_to edit_trainer_profile_recommendation_path(@trainer_profile,
        @recommendation), notice: "Recommendation could not be updated."
    end
  end
end

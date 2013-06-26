class TrainerProfilesController < ApplicationController

  def show
    @trainer_profile = TrainerProfile.find(params[:id])
    @trainer = @trainer_profile.user
    @recommendation = Recommendation.new

    unless @trainer.role == "trainer"
      redirect_to root_path, notice: "Resource does not exist"
    end
  end

  def edit
    if user_signed_in?
      @trainer_profile = TrainerProfile.find(params[:id])
      if @trainer_profile.owner?(current_user)
        @trainer = @trainer_profile.user
      else
        redirect_to root_path, notice: "Resource does not exist"
      end
    else
      redirect_to new_user_session_path, notice: "You must be signed in"
    end
  end

  def update
    
    @trainer_profile = TrainerProfile.find(params[:id])
    @specialties = params[:trainer_profile][:specialty_ids]
    @specialties.each do |specialty_id|
      @trainer_profile.trainer_specialties.build(specialty_id: specialty_id)
      binding.pry
    end
  end

end

class HomeController < ApplicationController

  def show
    @trainer_profiles = TrainerProfile.search_by_specialties(params[:query])
  end
end

class TrainerProfilesController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  # def index
  #   @articles = Article.text_search(params[:query]).page(params[:page]).per_page(3)
  # end

  def show
    @recommendation = Recommendation.new(trainer_profile_id: @trainer_profile.id)
  end

  def edit
    @trainer_specialties = @trainer_profile.trainer_specialties.build
    authorize! :manage, @trainer_profile
  end

  def update
    @specialties = params[:trainer_profile][:specialty_ids].reject! { |c| c.empty? }

    @trainer_profile.update_specialties(@specialties)

    redirect_to edit_trainer_profile_path(@trainer_profile),
      notice: "Profile updated"
  end
end

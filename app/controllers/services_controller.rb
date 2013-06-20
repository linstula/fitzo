class ServicesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @service = @user.services.build
  end

  def create
    @user = User.find(params[:user_id])
    @service = @user.services.build(params[:service])
  end
end

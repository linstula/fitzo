class ProfilesController < ApplicationController

  def show   
    @user = User.find(params[:user_id])
    @profile = @user.profile
    binding.pry
  end
end


# /users/11/profile
class ProfilesController < ApplicationController

  before_filter :user_is_trainer?, only: :show

  def show  

    if user_is_trainer? 
      @user = User.find(params[:user_id])
      @profile = @user.profile
    else
      redirect_to root_path, notice: "Resource does not exist"
    end 
    
  end

  private

  def user_is_trainer?
    @user = User.find(params[:user_id])
    @user.role == "trainer" 
  end

end

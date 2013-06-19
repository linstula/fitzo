class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])

    unless @user.role == "trainer"
      redirect_to root_path, notice: "Resource does not exist"
    end
  end

  def edit
    
  end

end

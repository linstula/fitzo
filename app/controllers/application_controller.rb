class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:notice] = "Access denied."
      redirect_to root_path
    else
      redirect_to new_user_session_path, notice: "You must be signed in"
    end
  end
end

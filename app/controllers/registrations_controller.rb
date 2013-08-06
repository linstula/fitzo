class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [:new]

  def new
    build_resource({role: params[:role] || "member"})
  end

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.role == "trainer"
        resource.create_profile_for_trainer
      end
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        if resource.role == "trainer"
          redirect_to trainer_profile_path(resource.trainer_profile)
        else
          respond_with resource, :location => after_sign_up_path_for(resource)
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end

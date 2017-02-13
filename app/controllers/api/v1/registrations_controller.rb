class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ActionController::MimeResponds
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  before_filter :configure_permitted_parameters

  def create
    build_resource(user_params)
    if resource.save
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json  { render :json => msg } 
      end
    else
      respond_to do |format|
        msg = { :status => "error", :message => resource.errors.full_messages.to_sentence, :html => "<b>...</b>" }
        format.json  { render :json => msg }
      end
    end
  end

  protected

  def user_params
  	params.require(:user).permit(:email, :first_name, :last_name, :dob, :uid)
  end

  def configure_permitted_parameters
	devise_parameter_sanitizer.sanitize(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email)
    end  	
  end
end
	
class Api::V1::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    build_resource(sign_up_params)
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

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
	
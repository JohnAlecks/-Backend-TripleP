class Users::RegistrationsController < Devise::RegistrationsController
  include ActionController::MimeResponds
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]

  def create
    user_registration
    if resource.persisted?
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!", :html => "<b>...</b>" }
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

  def user_registration
    self.resource = User.create(user_params)
  end

  def user_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end

class ApplicationController < ActionController::API	
  include ActionController::RequestForgeryProtection
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :password]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end

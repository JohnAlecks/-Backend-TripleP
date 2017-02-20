class ApplicationController < ActionController::API	

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def authenticate_user!
      redirect_to root_path unless user_signed_in? || current_user.present?
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :password]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end

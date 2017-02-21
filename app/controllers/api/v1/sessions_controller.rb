class Api::V1::SessionsController < Devise::SessionsController
	include ActionController::MimeResponds
	prepend_before_action :require_no_authentication, only: [:create]

	def create
		self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
		if api_v1_user_signed_in?
			respond_to do |format|
		        msg = { :status => "ok", :message => current_api_v1_user.inspect }
		        format.json  { render :json => msg } 
	      	end
	    else
	    	respond_to do |format|
		        msg = { :status => "Error", :message => "Failed!" }
		        format.json  { render :json => msg } 
	      	end
	    end
	end  

	
  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected 

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
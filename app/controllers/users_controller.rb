class UsersController < ApplicationController
	def index
		@users = User.all
		render json: @users
	end

	def create
    user = User.create(user_params)
    if user.persisted?
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def register
  	if request.post?
  		user = User.create(user_params)
  		if user.persisted?
  			redirect_to root_path
  		end
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :phone, :dob)
  end
end

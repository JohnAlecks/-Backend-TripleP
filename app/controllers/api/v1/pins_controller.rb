class Api::V1::PinsController < ApplicationController
	def get_pins
		pins = Pin.where(street: city)
		render json: pins
	end

	def city
		MatchingService.get_city(params[:latitude], params[:longtitude])
	end

	def create_pin
		pin = Pin.create(pin_params)
		if pin.persisted?
			respond_to do |format|
	        	msg = { :status => "OK", :message => "Successful" }
	        	format.json  { render :json => msg }
			end
		end
	end

	protected 

	def pin_params
		params.require(:pin).permit(:latitude, :longtitude)
	end
end
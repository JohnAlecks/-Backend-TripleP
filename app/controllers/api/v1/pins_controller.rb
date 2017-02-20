class Api::V1::PinsController < ApplicationController
	def get_pins
		current_city = MatchingService.get_city(10.777430, 106.664904)
		pins = Pin.where(street: current_city)
		render json: pins
	end

	def create_pin
		pin = current_user.pins.create(pin_params)
		if pin.persisted?
			
		end
	end

	protected 

	def pin_params
		params.require(:pin).permit(:latitude, :longtitude, :street, :user_id)
	end
end
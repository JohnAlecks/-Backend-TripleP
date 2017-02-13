class Api::V1::PinsController < ApplicationController
	def get_pins
		current_city = MatchingService.get_city(10.777430, 106.664904)
		pins = Pin.where(street: current_city)
		render json: pins
	end
end
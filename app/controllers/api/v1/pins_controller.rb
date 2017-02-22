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
			aws_region = nil
		  stream_name = 'kclrbsample'
		  shard_count = nil
		  sleep_between_puts = 0.25
		  timeout = 0
			kconfig = {}
		  kconfig[:region] = aws_region  if aws_region
		  kinesis = Aws::Kinesis::Client.new(kconfig)
			producer = StreamingDataService.new(kinesis, stream_name, sleep_between_puts, shard_count, pin)
  		producer.run(timeout)
			respond_to do |format|
	    	msg = { :status => "OK", :message => producer.get_record }
	    	format.json  { render :json => msg }
	    end
	  else
	  	respond_to do |format|
	    	msg = { :status => "Error Cannot Persist", :message => pin.new_record? }
	    	format.json  { render :json => msg }
	  	end
    end
	end

	protected 

	def pin_params
		params.require(:pin).permit(:latitude, :longtitude, :street)
	end
end
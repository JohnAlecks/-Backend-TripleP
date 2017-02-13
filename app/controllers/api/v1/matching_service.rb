class MatchingService
	require 'geocoder'
	extend Geocoder::Model::ActiveRecord

	def self.get_city(latitude, longtitude)
		geo_localization = "#{latitude},#{longtitude}"
		query = Geocoder.search(geo_localization).first
		query.sub_state
	end
end
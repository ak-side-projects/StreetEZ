json.key_format! ->(key){ key.gsub(/_/, "-") }

geolistings = rentals.reject{|rental| rental.address.longitude.blank? || rental.address.latitude.blank? }

json.array!(geolistings) do |rental|
    json.type "Feature"
    
		json.geometry do
      json.type "Point"
      json.coordinates [rental.address.longitude, rental.address.latitude]
    end
		
    json.properties do 
      json.title "<a href=\'#{rental_url(rental)}\'>#{rental.address.street}</a>"
      json.description "$#{rental.monthly_rent}"
      json.marker_color "#146AB9"
      json.marker_size "large"
      json.marker_id rental.id
    end
end
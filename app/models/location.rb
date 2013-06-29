class Location < ActiveRecord::Base
  attr_accessible :city, :state, :street_address, :zip_code

  after_validation :get_location_details

  def get_location_details
    self.full_address = "#{street_address} #{city}, #{state} #{zip_code}"
    loc = Geocoder.search(full_address)
    self.neighborhood = loc[0].neighborhood
    self.latitude = loc[0].coordinates[0]
    self.longitude = loc[0].coordinates[1]
  end
end

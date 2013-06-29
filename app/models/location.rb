class Location < ActiveRecord::Base
  has_many :trainer_profiles, 
    through: :trainer_locations
  has_many :trainer_locations

  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code

  validates :zip_code, :numericality => { :only_integer => true }
  validates_length_of :state, is: 2

  attr_accessible :city, :state, :street_address, :zip_code

  # after_validation :get_location_details

  def get_location_details
    self.full_address = "#{street_address} #{city}, #{state} #{zip_code}"
    loc = Geocoder.search(full_address)
    self.neighborhood = loc[0].neighborhood
    self.latitude = loc[0].coordinates[0]
    self.longitude = loc[0].coordinates[1]
  end
end

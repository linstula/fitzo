class Location < ActiveRecord::Base
  has_many :trainer_profiles, 
    through: :trainer_locations
  has_many :trainer_locations

  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state

  validates_length_of :state, is: 2

  attr_accessible :city, :state, :street_address

  # this should be a before_validaiton callback
  # instead of a before_save but it blows up the unit tests. 
  before_save :get_location_details

  def already_registered?
    get_full_address
    Location.find_by_full_address(full_address).present?
  end

  private

  def get_full_address
    self.full_address = "#{street_address.downcase} #{city.downcase}, #{state.downcase}"
  end

  def get_location_details
    loc = Geocoder.search(full_address)
    self.zip_code = loc[0].postal_code
    self.neighborhood = loc[0].neighborhood
    self.latitude = loc[0].coordinates[0]
    self.longitude = loc[0].coordinates[1]
  end
end

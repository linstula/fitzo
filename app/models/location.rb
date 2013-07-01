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

  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end

  def already_registered?
    get_full_address
    Location.find_by_full_address(full_address).present?
  end

  def valid_location?
    @loc_data = Geocoder.search(full_address)
    @loc_data.count == 1
  end

  private

  def get_full_address
    self.full_address = "#{street_address.downcase} #{city.downcase}, #{state.downcase}"
  end

  def get_location_details
    self.zip_code = @loc_data[0].postal_code
    self.neighborhood = @loc_data[0].neighborhood
    self.latitude = @loc_data[0].coordinates[0]
    self.longitude = @loc_data[0].coordinates[1]
  end
end

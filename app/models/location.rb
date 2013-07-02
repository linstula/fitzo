class Location < ActiveRecord::Base
  include PgSearch

  has_many :trainer_profiles, 
    through: :trainer_locations
  has_many :trainer_locations

  has_many :specialties,
    through: :trainer_profiles

  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code

  validates_length_of :state, is: 2

  validates_numericality_of :zip_code, only_integer: true
  validates_length_of :zip_code, is: 5

  attr_accessible :city, :state, :street_address, :zip_code


  # this should be a before_validaiton callback
  # instead of a before_save but it blows up the unit tests. 
  before_save :set_location_data

  acts_as_gmappable :process_geocoding => false

  pg_search_scope :location_search, 
    against: [:street_address, :zip_code, :neighborhood],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {
      specialties: :title
    }

  def self.search_for_locations(query)
    if query.present?
      locations = location_search(query)
      if locations.empty?
        locations = Location.all
      end
      locations
    else
      scoped
    end
  end

  def gmaps4rails_infowindow
    "<h2>" + self.trainer_profiles.first.user.first_name + "</h2>"
  end

  def gmaps4rails_address
    "#{latitude}, #{longitude}"
  end

  def make_full_address
    self.full_address = "#{street_address.titleize} #{city.capitalize}, #{state.upcase} #{zip_code}"
  end

  def already_registered?
    make_full_address
    Location.find_by_full_address(full_address).present?
  end

  def query_location_data
    Geocoder.search(full_address)
  end

  def definitive_result?
    @loc_data = query_location_data
    @loc_data.count == 1
  end

  def set_location_data
    self.neighborhood = @loc_data[0].neighborhood
    self.latitude = @loc_data[0].coordinates[0]
    self.longitude = @loc_data[0].coordinates[1]
  end
end

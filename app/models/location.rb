class Location < ActiveRecord::Base
  include PgSearch

  belongs_to :trainer_profile,
    counter_cache: true,
    touch: true

  delegate :owner_name, to: :trainer_profile, prefix: true

  has_many :specialties,
    through: :trainer_profile

  validates_presence_of :trainer_profile_id
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code

  validates_length_of :state, is: 2

  validates_numericality_of :zip_code, only_integer: true
  validates_length_of :zip_code, is: 5

  attr_accessible :city, :state, :street_address, :zip_code, :full_address

  before_save :set_location_data

  acts_as_gmappable :process_geocoding => false

  pg_search_scope :location_search,
    against: [:street_address, :zip_code, :neighborhood, :city],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {
      specialties: :title
    }

  def self.search_for_locations(query)
    if query.present?
      locations = location_search(query)
      if locations.empty?
        locations = Location.limit(30)
      end
      locations
    else
      scoped
    end
  end

  def definitive_result?
    @loc_data = query_location_data
    @loc_data.count == 1
  end

  def query_location_data
    make_full_address
    Geocoder.search(full_address)
  end

  def make_full_address
    self.full_address = "#{street_address.titleize} #{city.capitalize}, #{state.upcase} #{zip_code}"
  end

  def set_location_data
    self.neighborhood = @loc_data[0].neighborhood
    self.latitude = @loc_data[0].coordinates[0]
    self.longitude = @loc_data[0].coordinates[1]
  end
end

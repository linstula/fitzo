class Specialty < ActiveRecord::Base
  has_many :trainer_profiles, through: :trainer_specialties
  has_many :trainer_specialties,
    dependent: :destroy

  has_many :locations,
    through: :trainer_profile

  validates_presence_of :title

  attr_accessible :title

  after_save :touch_profiles

  private

  def touch_profiles
  	trainer_profiles.map(&:touch)
  end
end

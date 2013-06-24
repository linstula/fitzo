class Specialty < ActiveRecord::Base
  has_many :trainer_profiles, through: :trainer_specialties
  has_many :trainer_specialties, 
    dependent: :destroy

  validates_presence_of :title

  attr_accessible :title
end

class Specialty < ActiveRecord::Base
  has_many :trainer_profiles, through: :trainer_specialties
  has_many :trainer_specialties
  attr_accessible :title
end

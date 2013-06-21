class TrainerSpecialty < ActiveRecord::Base
  belongs_to :trainer_profile
  belongs_to :specialty

  validates_presence_of :trainer_profile_id, :specialty_id
  # attr_accessible :title, :body
end

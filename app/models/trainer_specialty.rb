class TrainerSpecialty < ActiveRecord::Base
  belongs_to :trainer_profile
  belongs_to :specialty

  validates_presence_of :trainer_profile_id, :specialty_id

  validates_uniqueness_of :trainer_profile_id, scoped: :user_id
  attr_accessible :trainer_profile_id, :specialty_id
end

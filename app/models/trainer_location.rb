class TrainerLocation < ActiveRecord::Base
  belongs_to :trainer_profile
  belongs_to :location

  validates_presence_of :trainer_profile_id, :location_id

  attr_accessible :location_id, :trainer_profile_id
end

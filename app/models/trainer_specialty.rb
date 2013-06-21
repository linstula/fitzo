class TrainerSpecialty < ActiveRecord::Base
  belongs_to :trainer_profile
  belongs_to :specialty
  # attr_accessible :title, :body
end

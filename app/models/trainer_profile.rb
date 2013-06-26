class TrainerProfile < ActiveRecord::Base
  belongs_to :user

  has_many :services,
    dependent: :destroy
  has_many :specialties, through: :trainer_specialties
  has_many :trainer_specialties, 
    dependent: :destroy
  has_many :recommendations, 
    dependent: :destroy

  validates_presence_of :user_id

  accepts_nested_attributes_for :services, allow_destroy: true

  attr_accessible :services_attributes

  def owner?(current_user)
    current_user == self.user
  end

  def add_specialties(specialties)
    specialties.each do |specialty_id|
      unless specialty_id.blank?
        if !self.specialties.include?(Specialty.find(specialty_id))
          self.trainer_specialties.create(specialty_id: specialty_id)
        end
      end
    end
  end

  def remove_specialties(specialties)
    self.trainer_specialties.each do | existing_trainer_specialty |
      if !specialties.include?(existing_trainer_specialty.specialty_id.to_s)
        existing_trainer_specialty.destroy
      end
    end
  end

  def update_specialties(specialties)
    add_specialties(specialties)
    remove_specialties(specialties)
  end
end

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

end

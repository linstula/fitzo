class TrainerProfile < ActiveRecord::Base
  belongs_to :user

  has_many :services

  validates_presence_of :user_id

  accepts_nested_attributes_for :services, allow_destroy: true

  attr_accessible :services_attributes
end

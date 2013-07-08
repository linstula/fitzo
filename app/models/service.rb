class Service < ActiveRecord::Base

  belongs_to :trainer_profile

  validates_presence_of :description, :duration, :price, :title, :trainer_profile_id
  validates :price, :numericality => { :only_integer => true }

  attr_accessible :category, :description, :duration, :price, :title, :trainer_profile_id
end

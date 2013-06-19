class Service < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :description, :duration, :price, :title, :user_id
  validates :price, :numericality => { :only_integer => true }
  validates :duration, :numericality => { :only_integer => true }

  attr_accessible :category, :description, :duration, :price, :title, :user_id
end

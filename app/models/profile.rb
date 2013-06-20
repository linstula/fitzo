class TrainerProfile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id
  # attr_accessible :title, :body
end

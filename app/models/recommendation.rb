class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trainer_profile, counter_cache: true

  validates_presence_of :title
  validates_presence_of :content

  validates_uniqueness_of :trainer_profile_id, :scope => :user_id

  attr_accessible :content, :title, :trainer_profile_id, :user_id

  delegate :full_name, to: :user, prefix: true

  def valid_recommendation?
    self.trainer_profile != self.user.trainer_profile
  end
end

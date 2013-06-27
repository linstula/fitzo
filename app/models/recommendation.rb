class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trainer_profile

  validates_presence_of :title
  validates_presence_of :content

  validates_uniqueness_of :trainer_profile_id, :scope => :user_id

  validate :not_recommending_self   # trainer can't recommend own profile

  attr_accessible :content, :title, :trainer_profile_id, :user_id

  def not_recommending_self
    if self.user && self.trainer_profile
      if self.trainer_profile == self.user.trainer_profile
        errors.add(:recommendation, "can't recommend yourself")
      end
    end
  end
end

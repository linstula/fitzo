class User < ActiveRecord::Base

  has_one :trainer_profile, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
       :username, :first_name, :last_name, :role, :avatar

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :first_name, :last_name, :username, :role
  validates_inclusion_of :role, in: ["member", "trainer"]

  def create_profile_for_trainer
    if self.role == 'trainer'
      self.build_trainer_profile.save
    end
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end

class User < ActiveRecord::Base

  after_save :create_profile_for_trainer

  has_one :profile, :dependent => :destroy
  has_many :services
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :role
  # attr_accessible :title, :body

  validates_presence_of :first_name, :last_name, :username, :role
  validates_inclusion_of :role, in: ["member", "trainer"]

  private

  def create_profile_for_trainer
    if self.role == 'trainer'
      self.build_profile.save
    end
  end
end

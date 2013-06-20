class User < ActiveRecord::Base
  has_one :trainer_profile
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :role
  # attr_accessible :title, :body

  validates_presence_of :first_name, :last_name, :username, :role
  validates_inclusion_of :role, in: ["user", "trainer"]
end

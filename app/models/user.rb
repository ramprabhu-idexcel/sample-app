class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name,:last_name,:phoneno,:age,:email, :password, :password_confirmation, :remember_me,:present_address,:permanent_address,:role_ids
  # attr_accessible :title, :body
  #relationship b/w user and ideas
  has_many :ideas,:dependent=>:destroy
  has_and_belongs_to_many :roles
  has_many :posts,:dependent=>:destroy  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
end

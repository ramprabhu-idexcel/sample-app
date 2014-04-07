class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name,:last_name,:phoneno,:age,:email, :password, :password_confirmation, :remember_me,:present_address,:permanent_address,:role_ids,:provider, :uid
  # attr_accessible :title, :body  
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts,:dependent => :destroy

  #User login with facebook
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(first_name: auth.info.first_name,last_name: auth.info.last_name,provider:auth.provider,uid:auth.uid,email:auth.info.email,password: Devise.friendly_token[0,20])
      end
    end
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  def self.find_for_facebook_oauth(data, signed_in_resource=nil)
      token = data['credentials']['token']
      email = data["extra"]["user_hash"]["email"]
      if user = User.find_by_email(email)
        user.authcode_facebook = token
        user.save
        user
      else # Create an user with a stub password.
        User.create!(
          :email => email, 
          :password => Devise.friendly_token[0,20],
          :first_name => data["user_info"]["first_name"],
          :last_name => data["user_info"]["last_name"]
        )
      end
    end
  
end

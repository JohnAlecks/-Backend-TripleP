class User < ApplicationRecord
  devise :database_authenticatable, 
  	     :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable, 
         :omniauthable,
         :authentication_keys => {email: true, login: false}
  acts_as_token_authenticatable
  def password_required?
    new_record? ? false : super
  end

  def resource_name
  	:user
  end

end

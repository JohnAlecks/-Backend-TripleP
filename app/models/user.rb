class User < ApplicationRecord
  devise :database_authenticatable, 
  	     :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable, 
         :omniauthable,
         :authentication_keys => {email: true, login: false}

  def password_required?
    new_record? ? false : super
  end

  def resource_name
  	:user
  end

end

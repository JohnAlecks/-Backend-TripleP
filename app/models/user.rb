class User < ApplicationRecord
  before_save :skip_confirmation!
  devise :database_authenticatable, 
  	     :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :trackable,
         :validatable, 
         :omniauthable,
         :authentication_keys => {email: true, login: false}

  def password_required?
    new_record? ? false : super
  end

end

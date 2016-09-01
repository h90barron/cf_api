class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  before_create :create_authentication_token!
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  def create_authentication_token!
    if !(self.class.exists?(auth_token: auth_token))
      self.auth_token = Devise.friendly_token
    end
  end
end

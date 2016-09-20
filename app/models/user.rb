class User < ActiveRecord::Base
  # Simple data model 
  validates :auth_token, uniqueness: true
  validates :longitude, :numericality => { less_than_or_equal_to: 180.0, greater_than_or_equal_to: -180.0 }
  validates :latitude, :numericality => { less_than_or_equal_to: 90.0, greater_than_or_equal_to: -90.0 }
  validates :radius, :numericality => { only_integer: true }
  before_create :create_authentication_token!
  
  # using devise 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  def create_authentication_token!
    if !(self.class.exists?(auth_token: auth_token))
      self.auth_token = Devise.friendly_token
    end
  end
  
  
end

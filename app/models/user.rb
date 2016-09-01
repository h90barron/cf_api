class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

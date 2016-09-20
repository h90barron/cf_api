class Api::V1::SessionsController < ApplicationController
  
  def create 
    email = params[:session][:email]
    if email.present?
      user = User.find_by(email: email)
    end
    
    
    password = params[:session][:password]
    
    if user.valid_password? password
      sign_in user, store: false
      user.create_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end
  
  # create and save new auth_token to deny access with current auth_token
  def destroy
    user = current_user
    user.create_authentication_token!
    user.save
    head 204
  end
  
  
end

module Authenticate
  
  # Overriding devise current_user method to work for RESTful sessions
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end
  
  def token_authentication!
    render json: { errors: "Not authenticated" }, status: :unauthorized unless current_user.present?
  end
  
  
  
end
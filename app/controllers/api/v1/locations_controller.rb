class Api::V1::LocationsController < ApplicationController
  # comment out before action to test locally without needing
  #   to autheniticate
  #before_action :token_authentication!, only: [:index]
  respond_to :json
  
  # TODO: index will return users clusters once clustering
  #   is working correctly. Testing now with simple response
  
  def index
    respond_with User.all
    #respond_with User.all.select(:longitude, :latitude)
  end
end

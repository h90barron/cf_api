class Api::V1::LocationsController < ApplicationController
  before_action :token_authentication!, only: [:index]
  #off only for ease of testing 
  respond_to :json
  def index
    #locations = Location.all
    respond_with User.all.select(:longitude, :latitude)
  end
end

class Api::V1::LocationsController < ApplicationController
  before_action :token_authentication!, only: [:index]
  respond_to :json
  def index
    #locations = Location.all
    respond_with Location.all
    #render json: locations, status: 200, location: [:api, locations]
    #respond_with Location.all
    #respond_with 200
  end
end

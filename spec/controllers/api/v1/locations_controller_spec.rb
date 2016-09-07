require 'spec_helper'

describe Api::V1::LocationsController do
  # describe "GET#index" do
  #   before(:each) do
  #     4.times { FactoryGirl.create :location }
  #     @user = FactoryGirl.create :user
  #   end
    
  #   context "when user is authenticated" do
  #     before(:each) do
  #       get :index, { user: @user }, format: :json
  #     end
      
  #     #temporarily set to respond with all locations
  #     it "should respond with a list of locations"
  #       location_response = JSON.parse(response.body, symbolize_names: true)
  #       expect(location_response[:locations].size).to eql 4
  #     end
  #   end
  
  describe "GET#index" do
    before(:each) do
      4.times { FactoryGirl.create :location }
      @user = FactoryGirl.create :user
      request.headers['Authorization'] = @user.auth_token
    end
    
    context "when user is authenticated and return is successful" do
      before(:each) do
        #@user = FactoryGirl.create :user
        get :index, format: :json
      end
      
      it "return json" do
        expect(json_response).to be_present
      end
    it { should respond_with 200 }
    end
    
    context "when user is not authenticated" do
      before(:each) do
        request.headers['Authorization'] = '123'
        get :index, format: :json
      end
      
      it "should return json error" do
        expect(json_response[:errors]).to be_present
      end
      
      it { should respond_with 401 }
    end
  end
end

require 'spec_helper'

describe Api::V1::UsersController do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end
    
    it "returns the correct email in the response" do
      user_response = json_response
      
      #user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end
    
    it { should respond_with 200 }
  end
  
  describe "POST #create" do
    
    context "when user is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes}, format: :json
      end
      
      it "renders the correct json for the user just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end
    
      it { should respond_with 201 }
    end
    
    context "when user is not succesfully created" do
      before(:each) do
        @invalid_user_attributes = { email: '1',
                                    password: "12345678",
                                    password_confirmation: "12345678" }
        post :create, { user: @invalid_user_attributes }, format: :json
      end
      
      it "renders json errors" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "should render error message on why user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      
      it { should respond_with 422 }
    end
  end
  
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers['Authorization'] = @user.auth_token
    end
    
    context "when user is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        #request.headers['Authorization'] = @user.auth_token
        patch :update,  { id: @user.id, user: { email: "goodemail@good.com" } }, format: :json
      end
      
      it "renders the json response with the updated user information" do
        user_response = json_response
        expect(user_response[:email]).to eql "goodemail@good.com"
      end
      
      it { should respond_with 200 }
      
    end
    
    context "when user is not successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        #request.headers['Authorization'] = @user.auth_token
        patch :update, { id: @user.id, user: { email: "1" } }, format: :json
      end
      
      it "should render json errors message" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "should render the error explanation in json" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      
      it { should respond_with 422 }
    end
    
    context "when user is not sucessfully updated due to lat/long" do
      before(:each) do
        @user = FactoryGirl.create :user
      end
      
      it "should fail validation of longitude out of range" do
        patch :update, { id: @user.id, user: { longitude: -190.0 } }, format: :json
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "should fail validation of latitude out of range" do
        patch :update, { id: @user.id, user: { latitude: 120.0 } }, format: :json
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
    end
    
  end
  
  
  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers[:Authorization] = @user.auth_token
      delete :destroy, { id: @user.id }, format: :json
    end
    
    it { should respond_with 204 }
  end
end

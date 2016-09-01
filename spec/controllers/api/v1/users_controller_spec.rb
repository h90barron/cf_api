require 'spec_helper'

describe Api::V1::UsersController do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end
    
    it "returns the correct email in the response" do
      user_response = JSON.parse(response.body, symbolize_names: true)
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
        user_response = JSON.parse(response.body, symbolize_names: true)
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
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
      
      it "should render error message on why user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      
      it { should respond_with 422 }
    end
  end
end

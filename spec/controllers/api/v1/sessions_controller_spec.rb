require 'spec_helper'

describe Api::V1::SessionsController do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
    end
    
    context "when the credentials are correct" do
      before(:each) do
        correct_credentials = { email: @user.email, password: "12345678" }
        post :create, { session: correct_credentials }
      end
      
      it "returns the correct user for the correct credentials" do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token
      end
      
      it { should respond_with 200 }
    end
    
    context "when credentials are incorrect" do
      before(:each) do
        incorrect_credentials = { email: @user.email, password: "1234567890" }
        post :create, { session: incorrect_credentials }
      end
      
      it "returns errors in json" do
        expect(json_response[:errors]).to include "Invalid email or password"
      end
      
      it {should respond_with 422 }
    end
  end
end

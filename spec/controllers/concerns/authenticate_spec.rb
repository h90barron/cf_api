require 'spec_helper'


class Authentication
  include Authenticate
end

describe Authenticate do
  let(:authentication) { Authentication.new }
  subject { authentication }
  
  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      authentication.stub(:request).and_return(request)
    end
    
    it "returns the current user from the auth header" do
      expect(authentication.current_user).to eql @user
    end
  end
  
  describe "#token_authentication!" do
    before do
      @user = FactoryGirl.create :user
      authentication.stub(:current_user).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({"errors" => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end
    
    it "renders a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end
    
    it { should respond_with 401 }
  end
  
end
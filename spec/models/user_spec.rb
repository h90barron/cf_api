require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  
  subject { @user }
  
  it {should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }
  
  it { should be_valid }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token) }
  
  describe "#create_authentication_token!" do 
    it "creates a unique token" do
      Devise.stub(:friendly_token).and_return("tokenabc456")
      @user.create_authentication_token!
      expect(@user.auth_token).to eql "tokenabc456"
    end
    
    it "creates a new token if one is already taken" do
      previous_user = FactoryGirl.create(:user, auth_token: "token123")
      @user.create_authentication_token!
      expect(@user.auth_token).not_to eql previous_user.auth_token
    end
  end
end

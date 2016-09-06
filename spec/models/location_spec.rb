require 'spec_helper'

describe Location do
  before { @location = FactoryGirl.build(:location) }
  subject { @location }
  
  it { should respond_to(:time) }
  it { should respond_to(:longitude) }
  it { should respond_to(:latitude) }
  it { should respond_to(:user_id) }

end

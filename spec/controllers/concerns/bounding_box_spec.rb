require 'spec_helper'

class BoundingTest
  include Bounding_Box
end


describe Bounding_Box do
  let(:bounding_test) { BoundingTest.new }
  subject { bounding_test }
  before(:each) do
    @first_user = FactoryGirl.create(:user, latitude: 34.752332, longitude: -92.340817)
    @second_user = FactoryGirl.create(:user, latitude: 34.752332, longitude: -92.305284)
    @third_user = FactoryGirl.create(:user, latitude: 34.753038, longitude: -92.275947) #over 5k box
    @fourth_user = FactoryGirl.create(:user, latitude: 34.770525, longitude: -92.222242)  #over 5k box
  end
  
 describe "#distance" do
   it "should return less than 5(km) using the predefined coordinates for users one and two" do
     dist_in_km = bounding_test.distance @first_user.latitude, @first_user.longitude, @second_user.latitude, @second_user.longitude
     expect(dist_in_km).to be < 5
    end
   it "shoud return greater than 5(km) using the predined coordinates for users one and three" do
     dist_in_km = bounding_test.distance @first_user.latitude, @first_user.longitude, @third_user.latitude, @third_user.longitude
     expect(dist_in_km).to be > 5
    end
  end
  
  describe "#users_in_bounding_box" do
    it "should return correct number of users" do
      expect(User.count).to eql 4
    end
    
    it "should return only 3 users within the bounding radius" do
      users = bounding_test.users_in_bounding_box 5, @first_user.latitude, @first_user.longitude
      expect(users.count).to eql 3
    end
  end
    
end
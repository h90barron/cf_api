module Geo_Helpers
  include Bounding_Box
  #####################################################
  # Module for generating users within a given area for
  # testing clustering methods. Must be included in console
  # environment manually if needed.
  #######################################################
  
  
  # creates 'iterations' # of users within 'radius' using lat/long as centerpoint
  def user_creation iterations, radius, lat, long
    values = users_in_bounding_box radius, lat, long, true
    
    iterations.times do
      user_coordinates = random_coordinate_generation values[0], values[1], values[2], values[3]
      FactoryGirl.create(:user, latitude: user_coordinates[0], longitude: user_coordinates[1])
    end
  end
    
  # generates random coordinates in specified range
  def random_coordinate_generation maxlat, minlat, maxlong, minlong
    
    lat = rand(minlat..maxlat)
    long = rand(minlong..maxlong)
    
    return lat, long
  end
  
  
end
module Bounding_Box
  ############################################################################
  # This if for all functions related to finding users within a given radius.
  #   'users_in_bounding_box' will return the users within a bounding box.
  #   'distance' can then be used to check if the user falls within the 
  #   circular radius. It should be noted that we will most likely neglect  
  #   using haversine distance in cluster calculations since the radius of 
  #   clusters will be small enough to ignore curvature. 
  ############################################################################
  
  
  
  # def users_in_bounding_box radius, lat, long
  #   radius = miles_to_km radius
    
  #   earth_radius = 6371
    
  #   maxlat = lat + radians_to_degree(radius / earth_radius)
  #   minlat = lat - radians_to_degree(radius / earth_radius)
    
  #   maxlong = long + radians_to_degree(radius / earth_radius) # / (Math::cos(degree_to_radians(lat))))
  #   minlong = long - radians_to_degree(radius / earth_radius) # / (Math::cos(degree_to_radians(lat))))
    
  #   users_in_bound = User.where("latitude >= ? AND latitude <= ? AND 
  #                           longitude >= ? AND longitude <= ?", maxlat, minlat, maxlong, minlong)
  #   users_in_bound = users_in_bound.select{
  #     |u| distance(lat, long, u.lat, u.long) < radius
  #   }
      
  #   return users_in_bound
  # end
  
  # TODO: use 'distance' to check if users in box are also in 
  #   circular radius.
  #   Can return min/max of lat/long or users in a bounding box.
  
  def users_in_bounding_box radius, lat, long, min_max_flag = false
    radius = miles_to_km radius
    
    earth_radius = 6371
    r = radius/earth_radius
    
    lat = degree_to_radians lat
    long = degree_to_radians long
    
    maxlat = lat + r
    minlat = lat - r
    
    long_prime = Math::asin(Math::sin(r)/Math::cos(lat))
    maxlong = long + long_prime
    minlong = long - long_prime
    
    maxlat = radians_to_degree maxlat
    minlat = radians_to_degree minlat
    maxlong = radians_to_degree maxlong
    minlong = radians_to_degree minlong
    
    if min_max_flag
      return maxlat.round(6), minlat.round(6), maxlong.round(6), minlong.round(6)
      
    else
    
    users_in_bound = User.where("latitude >= ? AND latitude <= ? AND 
                             longitude >= ? AND longitude <= ?", minlat, maxlat, minlong, maxlong)
    # users_in_bound = users_in_bound.select{
    #   |u| distance(lat, long, u.latitude, u.longitude) > radius
    # }
     return users_in_bound
    end
  end
  
  # REVIEW: make sure this is returning the correct distance
  
  def distance lat1, long1, lat2, long2
    #compute
    lat1 = degree_to_radians(lat1)
    long1 = degree_to_radians(long1)
    lat2 = degree_to_radians(lat2)
    long2 = degree_to_radians(long2)
    
    distance_between_points = Math::acos(Math::sin(lat1) * Math::sin(lat2) + Math::cos(lat1) * Math::cos(lat2) * Math::cos(long1 - long2))
                                
    return 6371 * distance_between_points                  
    
  end
  
  def degree_to_radians degree
    return degree * Math::PI / 180
  end
  
  def radians_to_degree radian
    return radian / (Math::PI/180)
  end
  
  def miles_to_km miles
    return miles / 0.62137119
  end
    
end
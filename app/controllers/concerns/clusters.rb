module Clusters 
  ################################################################
  # This module will contain the needed methods for centroid calculations
  #   of user clusters. 
  # Previously used methods have been removed. kmeans clustering
  #   implementation was cumbersome. Consider using raw sql for   
  #   kmeans or use a modified kernel density technique. 
  # TODO: kmeans clustering using known starting points. Kmeans++
  #   in the future.   
  ###############################################################

  
  # def kmeans_clustering local_users, starting_points
  #   local_users.each do |user|
  #     starting_points.each_with_index do |cluster_point, i|
  #       dist = (user.latitude - cluster_point[0])**2 + (user.longitude - cluster_point[1])**2
  #       if i == 0 or dist < min_dist
  #         min_dist = dist
  #         @cluster_id = i
  #       end
  #       #######
  #     end
  #   end
  # end
      
    
    
end
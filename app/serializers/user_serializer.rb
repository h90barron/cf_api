class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :longitude, :latitude, :location_time
end

class GpsPoint < ActiveRecord::Base
  validates :latitude, :longitude, :presence => true
end

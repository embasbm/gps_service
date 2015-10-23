class Trace < ActiveRecord::Base
  has_many :gps_points

  MILES_TO_METERS = 0.00062137

  def get_collection
    pgs_points_collection = []
    gps_points.each do |point|
      pgs_points_collection << { latitude: point.latitude, longitude: point.longitude, distance: point.distance }
    end
    pgs_points_collection
  end

  def update_distances
    start_point = gps_points.first
    gps_points.each do |point|
      distance = (point.distance_to(start_point) / MILES_TO_METERS).floor
      point.update_attributes(distance: distance)
    end
  end
end

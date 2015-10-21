class Trace < ActiveRecord::Base
  has_many :gps_points

  MILES_TO_METERS = 0.00062137

  def get_distances
    pgs_points_collection = []
    start_point = gps_points.first
    gps_points.each do |point|
      distance = (point.distance_to(start_point) / MILES_TO_METERS).floor
      pgs_points_collection << { latitude: point[:latitude], longitude: point[:longitude], distance: distance}
    end
    pgs_points_collection
  end
end

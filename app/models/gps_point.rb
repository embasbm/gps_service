class GpsPoint < ActiveRecord::Base
  validates_presence_of :latitude, :longitude
  belongs_to :trace

  acts_as_mappable :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

end

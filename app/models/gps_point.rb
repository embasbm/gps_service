class GpsPoint < ActiveRecord::Base
  validates :latitude, :longitude, :presence => true
  belongs_to :trace
end

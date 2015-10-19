class GpsPoint < ActiveRecord::Base
  validates :latitude, uniqueness: {scope: :longitude}, :presence => true
  belongs_to :trace
end

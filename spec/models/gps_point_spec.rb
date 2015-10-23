require 'rails_helper'

RSpec.describe GpsPoint, :type => :model do
  context 'fields' do
    gps_point = GpsPoint.new(latitude: '', longitude: '')
    it 'latitude is missing, record is nil' do
      expect(gps_point).not_to be_valid
    end
    it 'longitude is missing, record is nil' do
      expect(gps_point).not_to be_valid
    end
    it 'record is valid if both fields are present' do
      gps_point.latitude = '117.230323791504'
      gps_point.longitude = '117.230323791504'
      expect(gps_point).to be_valid
    end
    it 'latitude record could be negative' do
      gps_point.latitude = '-117.230323791504'
      expect(gps_point).to be_valid
    end
    it 'longitude record could be negative' do
      gps_point.longitude = '-117.230323791504'
      expect(gps_point).to be_valid
    end
    it 'both field could be negative' do
      gps_point.latitude = '-117.230323791504'
      gps_point.longitude = '-117.230323791504'
      expect(gps_point).to be_valid
    end
  end
  context 'duplicate gps point' do
    it 'record is valid if both fields are present' do
      gps_point = GpsPoint.create(latitude: '117.230323791504', longitude: '117.230323791504')
      expect(gps_point).to be_valid
      gps_point_dup = GpsPoint.create(latitude: '117.230323791504', longitude: '117.230323791504')
      expect(gps_point_dup).to be_valid
    end
  end
end

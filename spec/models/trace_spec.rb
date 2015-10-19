require 'rails_helper'

RSpec.describe Trace, :type => :model do
  before { @trace = Trace.create }
  context 'empty' do
    it 'may content zero points' do
      expect(@trace).to be_valid
    end
  end
  context 'contains points' do
    it 'may content more than one ' do
      gps_point_1 = GpsPoint.create(latitude: '117.230323791504', longitude: '117.230323791504', trace_id: @trace.id)
      gps_point_2 = GpsPoint.create(latitude: '117.230323791504', longitude: '117.230323791504', trace_id: @trace.id)
      expect(@trace.gps_points.count).to eq(2)
    end
  end
end

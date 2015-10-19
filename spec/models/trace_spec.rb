require 'rails_helper'

RSpec.describe Trace, :type => :model do
  describe 'points' do
    trace = Trace.new
    it 'may content zero points' do
      expect(trace).to be_valid
    end
  end
end

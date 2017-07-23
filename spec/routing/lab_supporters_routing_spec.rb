require 'spec_helper'

describe LabSupportersController do
  describe 'routing' do

    it 'routes to #support' do
      expect(get: '/labs/1/support').to route_to('lab_supporters#support', lab_id: '1')
    end

    it 'routes to #unsupport' do
      expect(get: '/labs/1/unsupport').to route_to('lab_supporters#unsupport', lab_id: '1')
    end

    it 'routes to #index' do
      expect(get: '/labs/1/supporters').to route_to('lab_supporters#supporters', lab_id: '1')
    end
  end
end

require 'rails_helper'

describe Api::SrpmsController do
  describe 'routing' do
    it 'should route /api/srpms/:id to api/srpms#show' do
      expect(get: 'api/srpms/openbox').to route_to(
        controller: 'api/srpms',
        action: 'show',
        format: 'json',
        id: 'openbox'
      )
    end

    pending 'should route /api/srpms/:id.json to api/srpms#show' do
      expect(get: 'api/srpms/openbox.json').to route_to(
        controller: 'api/srpms',
        action: 'show',
        format: 'json',
        id: 'openbox'
      )
    end
  end
end

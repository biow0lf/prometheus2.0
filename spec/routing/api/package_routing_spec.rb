require 'rails_helper'

describe Api::PackageController do
  describe 'routing' do
    it 'should route GET /api/packages/:id to api/package#show' do
      expect(get: 'api/packages/openbox').to route_to(
        controller: 'api/package',
        action: 'show',
        format: 'json',
        id: 'openbox')
    end

    pending 'should route GET /api/packages/:id.json to api/package#show' do
      expect(get: 'api/packages/openbox.json').to route_to(
        controller: 'api/package',
        action: 'show',
        format: 'json',
        id: 'openbox')
    end
  end
end

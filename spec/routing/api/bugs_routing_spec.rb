require 'rails_helper'

describe Api::BugsController do
  describe 'routing' do
    it 'should route /api/bugs/:id to api/bugs#show' do
      expect(get: '/api/bugs/22555').to route_to(
        controller: 'api/bugs',
        action: 'show',
        format: 'json',
        id: '22555')
    end

    it 'should route /api/bugs/:id.json to api/bugs#show' do
      expect(get: 'api/bugs/22555').to route_to(
        controller: 'api/bugs',
        action: 'show',
        format: 'json',
        id: '22555')
    end
  end
end

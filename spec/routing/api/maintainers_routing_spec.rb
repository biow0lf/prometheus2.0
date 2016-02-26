require 'rails_helper'

describe Api::MaintainersController do
  describe 'routing' do
    it 'should route GET /api/maintainers to api/maintainers#index' do
      expect(get: '/api/maintainers').to route_to(
        controller: 'api/maintainers',
        action: 'index',
        format: 'json')
    end

    it 'should route GET /api/maintainers.json to api/maintainers#index' do
      expect(get: '/api/maintainers.json').to route_to(
        controller: 'api/maintainers',
        action: 'index',
        format: 'json')
    end

    it 'should route GET /api/maintainers/:id to api/maintainers#show' do
      expect(get: '/api/maintainers/icesik').to route_to(
        controller: 'api/maintainers',
        action: 'show',
        id: 'icesik',
        format: 'json')
    end

    it 'should route GET /api/maintainers/:id.json to api/maintainers#show' do
      expect(get: '/api/maintainers/icesik.json').to route_to(
        controller: 'api/maintainers',
        action: 'show',
        id: 'icesik',
        format: 'json')
    end
  end
end

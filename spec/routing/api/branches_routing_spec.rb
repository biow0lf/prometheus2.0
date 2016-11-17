require 'rails_helper'

describe Api::BranchesController do
  describe 'routing' do
    it 'should route GET /api/branches to api/branches#index' do
      expect(get: '/api/branches').to route_to(
        controller: 'api/branches',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route GET /api/branches.json to api/branches#index' do
      expect(get: '/api/branches.json').to route_to(
        controller: 'api/branches',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route GET /api/branches/:id to api/branches#show' do
      expect(get: '/api/branches/1').to route_to(
        controller: 'api/branches',
        action: 'show',
        format: 'json',
        id: '1'
      )
    end

    it 'should route GET /api/branches/:id.json to api/branches#show' do
      expect(get: '/api/branches/1.json').to route_to(
        controller: 'api/branches',
        action: 'show',
        format: 'json',
        id: '1'
      )
    end
  end
end

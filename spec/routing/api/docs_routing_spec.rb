require 'rails_helper'

describe Api::DocsController do
  describe 'routing' do
    it 'should route /api/docs to api/docs#index' do
      expect(get: '/api/docs').to route_to(
        controller: 'api/docs',
        action: 'index',
        format: 'json')
    end

    it 'should route /api/docs.json to api/docs#index' do
      expect(get: '/api/docs.json').to route_to(
        controller: 'api/docs',
        action: 'index',
        format: 'json')
    end
  end
end

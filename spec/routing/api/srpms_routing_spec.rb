# frozen_string_literal: true

require 'rails_helper'

describe Api::SrpmsController do
  describe 'routing' do
    it 'should route GET /api/srpms to api/srpms#index' do
      expect(get: 'api/srpms').to route_to(
        controller: 'api/srpms',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route GET /api/srpms.json to api/srpms#index' do
      expect(get: 'api/srpms.json').to route_to(
        controller: 'api/srpms',
        action: 'index',
        format: 'json'
      )
    end

    it 'should route GET /api/srpms/:id to api/srpms#show' do
      expect(get: 'api/srpms/openbox').to route_to(
        controller: 'api/srpms',
        action: 'show',
        format: 'json',
        id: 'openbox'
      )
    end

    pending 'should route GET /api/srpms/:id.json to api/srpms#show' do
      expect(get: 'api/srpms/openbox.json').to route_to(
        controller: 'api/srpms',
        action: 'show',
        format: 'json',
        id: 'openbox'
      )
    end
  end
end

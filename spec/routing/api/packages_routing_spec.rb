# frozen_string_literal: true

require 'rails_helper'

describe Api::PackagesController do
  describe 'routing' do
    it 'should route GET /api/srpms/:srpm_id/packages to api/packages#index' do
      expect(get: '/api/srpms/openbox/packages').to route_to(
        controller: 'api/packages',
        action: 'index',
        srpm_id: 'openbox',
        format: 'json'
      )
    end

    it 'should route GET /api/srpms/:srpm_id/packages.json to api/packages#index' do
      expect(get: '/api/srpms/openbox/packages.json').to route_to(
        controller: 'api/packages',
        action: 'index',
        srpm_id: 'openbox',
        format: 'json'
      )
    end
  end
end

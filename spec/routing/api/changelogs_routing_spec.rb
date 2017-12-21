# frozen_string_literal: true

require 'rails_helper'

describe Api::ChangelogsController do
  describe 'routing' do
    it 'should route GET /api/srpms/:srpm_id/changelogs to api/changelogs#index' do
      expect(get: '/api/srpms/openbox/changelogs').to route_to(
        controller: 'api/changelogs',
        action: 'index',
        srpm_id: 'openbox',
        format: 'json'
      )
    end

    it 'should route GET /api/srpms/:srpm_id/changelogs.json to api/changelogs#index' do
      expect(get: '/api/srpms/openbox/changelogs.json').to route_to(
        controller: 'api/changelogs',
        action: 'index',
        srpm_id: 'openbox',
        format: 'json'
      )
    end
  end
end

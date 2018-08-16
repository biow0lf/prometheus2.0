# frozen_string_literal: true

require 'rails_helper'

describe SrpmOpenedBugsController do
  describe 'routing' do
    it 'should route /sisyphus/srpms/:id/bugs to srpm_opened_bugs#index' do
      expect(get: '/sisyphus/srpms/glibc/bugs').to route_to(
        controller: 'srpm_opened_bugs',
        action: 'index',
        id: 'glibc',
        branch: 'sisyphus'
      )
    end

    it 'should route /:locale/sisyphus/srpms/:id/bugs to srpm_opened_bugs#index' do
      expect(get: '/en/sisyphus/srpms/glibc/bugs').to route_to(
        controller: 'srpm_opened_bugs',
        action: 'index',
        id: 'glibc',
        locale: 'en',
        branch: 'sisyphus'
      )
    end
  end
end

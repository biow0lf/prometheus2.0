# frozen_string_literal: true

require 'rails_helper'

describe SrpmOpenedBugsController do
  describe 'routing' do
    it 'should route /Sisyphus/srpms/:id/bugs to srpm_opened_bugs#index' do
      expect(get: '/Sisyphus/srpms/glibc/bugs').to route_to(
        controller: 'srpm_opened_bugs',
        action: 'index',
        id: 'glibc',
        branch: 'Sisyphus'
      )
    end

    it 'should route /:locale/Sisyphus/srpms/:id/bugs to srpm_opened_bugs#index' do
      expect(get: '/en/Sisyphus/srpms/glibc/bugs').to route_to(
        controller: 'srpm_opened_bugs',
        action: 'index',
        id: 'glibc',
        locale: 'en',
        branch: 'Sisyphus'
      )
    end
  end
end
